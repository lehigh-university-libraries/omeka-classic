<?php

declare(strict_types=1);

$config = parse_ini_file('/var/www/omeka-classic/db.ini', true, INI_SCANNER_RAW);
$database = $config['database'] ?? null;

if (!is_array($database)) {
    fwrite(STDERR, "db.ini omitted [database]\n");
    exit(2);
}

foreach (['host', 'port', 'username', 'password', 'dbname'] as $key) {
    $value = $database[$key] ?? '';
    if (!is_string($value) || $value === '') {
        fwrite(STDERR, "db.ini database.$key is empty\n");
        exit(2);
    }
    fwrite(STDOUT, $value . "\0");
}
