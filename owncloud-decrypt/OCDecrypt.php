<?php

require_once 'OCDecryptBase.php';

class OCDecrypt extends OCDecryptBase {

    public $re_encfile_hd = '#^HBEGIN:.+:cipher:(.+):HEND-+([^-].*)#s';
    public $re_encfile_data = '#(.+)00iv00(.+)xx#sU';

    public $re_privkey = '#^HBEGIN:cipher:(.+):HEND(.+)00iv00(.+)xx$#s';

    public function getUserPrivateKeyPassword($user, $user_password, $cipher) {
        return $user_password;
    }

    public function getUserPrivateKey($user, $user_password, $file) {
        $priv_data = file_get_contents($this->OC_PATH . '/' . $user . '/files_encryption/OC_DEFAULT_MODULE/' . $user . '.privateKey');
        if($priv_data === False) {
            return 1;
        }

        if(preg_match($this->re_privkey, $priv_data, $matches) === 0) {
            array_push($this->errors, 'Cannot match private key regex against user\'s private key');
            return 4;
        }

        $priv_cipher_xtra = explode(':', $matches[1]);
        $priv_cipher = $priv_cipher_xtra[0];
        $priv_enc = $matches[2];
        $priv_iv = $matches[3];

        if($this->bDebug) {
            echo __FUNCTION__ . '.Cipher: ' . $priv_cipher . "\n";
            echo __FUNCTION__ . '.Enc   : ' . $priv_enc . "\n";
            echo __FUNCTION__ . '.IV    : ' . $priv_iv . "\n";
        }

        $key_pass = $this->getUserPrivateKeyPassword($user, $user_password, $priv_cipher);
        $priv_kd = openssl_decrypt($priv_enc, $priv_cipher, $key_pass, false, $priv_iv);

        if($this->bDebug) {
            echo __FUNCTION__ . '.KD    : ' . $priv_kd . "\n";
        }

        if($priv_kd === False) {
            return 2;
        }

        if(openssl_pkey_export($priv_kd, $priv_plain) === False) {
            return 3;
        }

        if($this->bDebug) {
            echo __FUNCTION__ . '.Plain : ' . $priv_plain . "\n";
        }

        return $priv_plain;
    }

}
