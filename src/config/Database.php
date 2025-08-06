<?php
declare(strict_types=1);

namespace App\config;

use PDO;

class Database {
    // Creamos la instancia de PDO que es para la conexión a la base de datos
    private static ?PDO $instance = null;
    public static function getConnection(): PDO {
        if(self::$instance === null){
            $host = 'localhost';
            $dbName = "project_db";
            $user = 'root'; //Esto no se debe hacer en producción carajo :v
            $password = 'winters20042'; //Esto tampoco xd, nomás por aprender con DB
            $charset = 'utf8mb4';

            $dsn = "mysql:host={$host};dbname={$dbName};charset={$charset}";
            $options = [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false
            ];
            self::$instance = new PDO($dsn, $user, $password, $options);
        }
        return self::$instance;
    }
}