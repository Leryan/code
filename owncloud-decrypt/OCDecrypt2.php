<?php

require_once 'OCDecryptBase.php';

class OCDecrypt2 extends OCDecryptBase {

    public $re_encfile_hd = '#HBEGIN:oc_encryption_module:OC_DEFAULT_MODULE:cipher:(.*):HEND-+([^-].*)$#s';
    // FIXME: this regex will break if IV is something like: <data>x, as regex is configured non-greedy.
    public $re_encfile_data = '#(.+)00iv00(.+)xx#sU';

    public $re_privkey = '#^HBEGIN:cipher:(.+):keyFormat:(.+):HEND(.+)00iv00(.+)xx$#s';

    public function getUserPrivateKeyPassword($user, $user_password, $cipher) {
        // https://github.com/nextcloud/server/blob/master/apps/encryption/lib/Crypto/Crypt.php#L350
        $salt = hash('sha256', $user . $this->instanceId . $this->instanceSecret, true);

        $iv_size = $this->getIVSize($cipher);
        $key_pass = hash_pbkdf2('sha256', $user_password, $salt, 100000, $iv_size, true);

        if($this->bDebug) {
            echo __FUNCTION__ . '.SaltParams: ' . $user . $this->instanceId . $this->instanceSecret . "\n";
            echo __FUNCTION__ . '.Salt: ' . bin2hex($salt) . "\n";
            echo __FUNCTION__ . '.KeySize: ' . $iv_size . "\n";
            echo __FUNCTION__ . '.KeyPass: ' . bin2hex($key_pass) . "\n";
        }

        return $key_pass;
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

        $priv_cipher = $matches[1];
        $priv_keyfmt = $matches[2];
        $priv_enc = $matches[3];
        $priv_iv = $matches[4];

        if($this->bDebug) {
            echo __FUNCTION__ . '.Cipher: ' . $priv_cipher . "\n";
            echo __FUNCTION__ . '.KeyFmt: ' . $priv_keyfmt . "\n";
            echo __FUNCTION__ . '.Enc   : ' . $priv_enc /*bin2hex($priv_enc)*/ . "\n";
            echo __FUNCTION__ . '.IV    : ' . $priv_iv /*bin2hex($priv_iv)*/ . "\n";
        }

        $key_pass = $this->getUserPrivateKeyPassword($user, $user_password, $priv_cipher);
        $priv_kd = openssl_decrypt($priv_enc, $priv_cipher, $key_pass, false, $priv_iv);

        if($this->bDebug) {
            echo __FUNCTION__ . '.KD    : ' . bin2hex($priv_kd) . "\n";
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
