<?php

declare(strict_types=1);

chdir('/var/www/omeka-classic');

switch ($argv[1] ?? '') {
    case 'version':
        require 'bootstrap.php';
        echo OMEKA_VERSION;
        break;

    case 'metadata':
        $_SERVER['HTTP_HOST'] = '127.0.0.1';
        $_SERVER['SCRIPT_NAME'] = '/index.php';
        require 'bootstrap.php';
        $application = new Omeka_Application(APPLICATION_ENV);
        $application->bootstrap(['Config', 'Db', 'Options']);
        echo json_encode([
            'title' => get_option('site_title'),
            'theme' => get_option('public_theme'),
            'database_version' => get_option('omeka_version'),
        ], JSON_THROW_ON_ERROR);
        break;

    default:
        fwrite(STDERR, "usage: omeka-classic-inspect.php {version|metadata}\n");
        exit(2);
}
