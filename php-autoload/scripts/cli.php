<?php

require_once join(DIRECTORY_SEPARATOR, array(__DIR__, '..', 'classes', 'Autoload', 'Setup.php'));

\Autoload\Setup::setup(array('App', 'App2'));
\App\App::hi();
\App2\App::hi();
