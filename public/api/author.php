<?php

require __DIR__  . '/../../vendor/autoload.php';

use App\controllers\AuthorController;

(new AuthorController())->handle();
