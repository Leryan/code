<?php

function print_help() {
    global $argv;
    echo "php $argv[0] -u user -p password -f file [-D /var/www/owncloud/data] [-d]\n";
    echo "    -d: enable debugging /!\\ private keys will be printed on screen /!\\\n";
}

$bDebug = false;
$sUser = null;
$sPassword = null;
$sDataPath = '/var/www/owncloud/data';
$sFile = null;
$sMode = '';
$sInstanceID = null;
$sInstanceSecret = null;

$sShortOpts = 'u:p:D:f:m:i:I:dh';

$options = getopt($sShortOpts);

if($options === false) {
    print("getopt() failure.\n");
    exit(1);
}

if(isset($options['d'])) {
    $bDebug = true;
}

if(isset($options['D'])) {
    $sDataPath = $options['D'];
}

if(isset($options['f'])) {
    $sFile = $options['f'];
}

if(isset($options['u'])) {
    $sUser = $options['u'];
}

if(isset($options['p'])) {
    $sPassword = $options['p'];
}

if(isset($options['m'])) {
    $sMode = $options['m'];
}

if(isset($options['i'])) {
    $sInstanceID = $options['i'];
}

if(isset($options['I'])) {
    $sInstanceSecret = $options['I'];
}

if($sUser === null || $sPassword === null || $sFile === null || isset($options['h'])) {
    print_help();
    exit(1);
}

require_once 'OCDecrypt' . $sMode . '.php';

// This is dirty, i know. If anyone wants to clean that, you're welcome.
$class = 'OCDecrypt' . $sMode;

$OCD = new $class($sDataPath, $sInstanceID, $sInstanceSecret, $bDebug);

$ret = $OCD->decrypt($sUser, $sPassword, $sFile);
if($ret === 0) {
    print("Decrypted $sFile\n");
} else {
    print("Cannot decrypt $sFile:\n");
    foreach($OCD->errors as $error) {
        print("=> $error\n");
    }
}
exit($ret);
