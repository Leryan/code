<?php

require_once 'OCDecrypt2.php';

class OCDecrypt3 extends OCDecrypt2 {

    public $re_encfile_hd = '#HBEGIN:oc_encryption_module:OC_DEFAULT_MODULE:cipher:(.+):signed:.+:HEND-+([^-].*)$#s';
    public $re_encfile_data = '#(.+)00iv00(.+)00sig00[a-f0-9]+xxx#sU';

    public $re_privkey = '#^HBEGIN:cipher:(.+):keyFormat:(.+):HEND(.+)00iv00(.+)(00sig00.*x)xx$#s';

}
