<?php

class OCDecryptBase {

    public $OC_PATH = null;
    public $bDebug = null;
    public $instanceId = null;
    public $instanceSecret = null;
    public $errors = array();

    public function __construct($OC_PATH, $sInstanceID = null, $sInstanceSecret = null, $bDebug = false) {
        $this->OC_PATH = $OC_PATH;
        $this->bDebug = $bDebug;
        $this->instanceId = $sInstanceID; // config.php
        $this->instanceSecret = $sInstanceSecret; //config.php
    }

    public $cipher_ivsize = [
        'AES-256-CTR' => 32,
        'AES-128-CTR' => 16,
        'AES-256-CFB' => 32,
        'AES-128-CFB' => 16,
    ];

    public function getIVSize($cipher) {
        if (array_key_exists($cipher, $this->cipher_ivsize)) {
            $size = $this->cipher_ivsize[$cipher];
        } else {
            $size = openssl_cipher_iv_length($cipher);
        }

        return $size;
    }

    public function getFileKey($user, $file, $shared_plain, $priv_plain) {
        $fk_fpath = $this->OC_PATH . '/' . $user . '/files_encryption/keys/files/' . $file . '/OC_DEFAULT_MODULE/fileKey';
        if($this->bDebug) {
            echo __FUNCTION__ . '.fileKey: ' . $fk_fpath . "\n";
        }
        $fk_enc = file_get_contents($fk_fpath);
        if($fk_enc === False) {
            return 1;
        }
        if(!openssl_open($fk_enc, $fk_plain, $shared_plain, $priv_plain)) {
            return 2;
        }
        return $fk_plain;
    }

    public function getShareKey($user, $file) {
        $shared_file = $this->OC_PATH . '/' . $user . '/files_encryption/keys/files/' . $file . '/OC_DEFAULT_MODULE/' . $user . '.shareKey';
        if($this->bDebug) {
            echo __FUNCTION__ . '.shared_file : ' . $shared_file . "\n";
        }
        $shared_enc = file_get_contents($shared_file);
        $shared_plain = $shared_enc;

        return $shared_plain;
    }

    /**
     * Return headers and data
     */
    public function getEncFileHD($data) {
        $mres = preg_match($this->re_encfile_hd, $data, $matches);
        if($mres === false || count($matches) === 0) {
            array_push($this->errors, 'Cannot match header and data against encrypted file');
            return false;
        }

        return $matches;
    }

    public function getEncDataChunks($data) {
        $mres = preg_match_all($this->re_encfile_data, $data, $matches);
        if($mres === false || count($matches) === 0) {
            array_push($this->errors, 'Cannot match data chunks against encrypted file');
            return false;
        }

        return $matches;
    }

    public function decryptFile($user, $file, $fk_plain) {
        $data_encfpath = $this->OC_PATH . '/' . $user . '/files/' . $file;
        if($this->bDebug) {
            echo __FUNCTION__ . '.EncFilePath: ' . $data_encfpath . "\n";
        }
        $data_data = file_get_contents($data_encfpath);
        if($data_data === False) {
            return 1;
        }

        $matches = $this->getEncFileHD($data_data);
        if($matches === false) {
            return 2;
        }

        $data_cipher = $matches[1];
        $data_enc = $matches[2];

        $matches = $this->getEncDataChunks($data_enc);
        if($matches === false) {
            return 2;
        }

        $data_plain = array();
        foreach ($matches[1] as $i => $match) {

            $data_enc = $match;
            $data_iv = $matches[2][$i];

            $data = openssl_decrypt($data_enc, $data_cipher, $fk_plain, false, $data_iv);
            array_push($data_plain, $data);
        }

        return $data_plain;
    }

    public function decrypt($user, $user_password, $file) {
        $shared_plain = $this->getShareKey($user, $file);
        if($shared_plain === False) {
            return 1;
        }

        $priv_plain = $this->getUserPrivateKey($user, $user_password, $file);
        if($priv_plain >= 1 && $priv_plain <= 4) {
            return 2;
        }

        $fk_plain = $this->getFileKey($user, $file, $shared_plain, $priv_plain);
        if($fk_plain >= 1 && $fk_plain <= 2) {
            return 3;
        }

        $data_plain = $this->decryptFile($user, $file, $fk_plain);
        if(($data_plain >= 1 && $data_plain <= 2) || $data_plain === False) {
            return 4;
        }

        $fpath = 'decrypted/' . $user . '/' . dirname($file);
        if(!is_dir($fpath)) {
            mkdir($fpath, 0700, True);
        }
        if(file_put_contents($fpath . '/' . basename($file), join('', $data_plain)) === False) {
            return 5;
        }

        return 0;
    }

}
