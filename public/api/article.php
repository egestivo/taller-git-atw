<?php

require __DIR__  . '/../../vendor/autoload.php';

use App\controllers\ArticleController;

(new ArticleController())->handle();
