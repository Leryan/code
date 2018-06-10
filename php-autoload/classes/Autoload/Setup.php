<?php namespace Autoload;

class Setup {

    private static $hManagedNamespaces;

    public static function autoload($sClassName) {
        $aClassPath = explode('\\', $sClassName);

        if (isset(self::$hManagedNamespaces[$aClassPath[0]])) {
            array_unshift($aClassPath, __DIR__, '..');
            require_once join(DIRECTORY_SEPARATOR, $aClassPath) . '.php';
            return true;
        }

        return false;
    }

    public static function register_autoload() {
        spl_autoload_register(Array(__CLASS__, 'autoload'));
    }

    public static function register_managed_namespaces($aNamespaces) {
        foreach ($aNamespaces as $sMN) {
            self::$hManagedNamespaces[$sMN] = true;
        }
    }

    public static function setup($aManagedNamespaces) {
        self::register_managed_namespaces($aManagedNamespaces);
        self::register_autoload();
    }
}
