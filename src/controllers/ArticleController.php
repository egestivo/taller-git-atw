<?php

declare(strict_types=1);

namespace App\controllers;

use App\repositories\ArticleRepository;
use App\repositories\AuthorRepository;
use App\entities\Article;
use App\entities\Author;

class ArticleController {
    private ArticleRepository $articleRepository;
    private AuthorRepository $authorRepository;

    public function __construct() {
        $this->articleRepository = new ArticleRepository();
        $this->authorRepository = new AuthorRepository();
    }

    public function handle(): void {
        header('Content-Type: application/json');
        $method = $_SERVER['REQUEST_METHOD'];

        if (isset($_GET['id'])) {
            $article = $this->articleRepository->findById((int) $_GET['id']);
            echo json_encode($article ? $this->articleToArray($article) : null);
            return;
        } else {
            $list = array_map(
                [$this,'articleToArray'], 
                $this->articleRepository->findAll()
            );
            echo json_encode($list);
        }

        $payload = json_decode(file_get_contents('php://input'), true);

        if ($method === 'POST') {

            $author = $this->authorRepository->findById((int)$payload['authorId'] ?? 0);

            if (!$author) {
                http_response_code(400);
                echo json_encode(['error' => 'No existe el autor, bobaso']);
                return;
            }

            $article = new Article(
                0,
                $payload['title'],
                $payload['description'],
                new \DateTime($payload['publicationDate'] ?? 'now'),
                $author,
                'article',
                (int)$payload['edition'] ?? 1,
                $payload['doi'],
                $payload['abstract'],
                $payload['keywords'],
                $payload['indexation'],
                $payload['magazine'],
                $payload['area']
            );

            echo json_encode([
                'success' => $this->articleRepository->create($article),
            ]);
            return;
        }

        if ($method === 'PUT') {
            $id = (int)($payload['id'] ?? 0);
            $existing = $this->articleRepository->findById($id);
            if (!$existing) {
                http_response_code(404);
                echo json_encode(['error' => 'Article not found']);
                return;
            }

            if (isset($payload['authorId'])) {
                $author = $this->authorRepository->findById((int)$payload['authorId'] ?? 0);
                if ($author) $existing->setAuthor($author);
            }

            if(isset($payload['title'])) $existing->setTitle($payload['title']);
            if(isset($payload['description'])) $existing->setDescription($payload['description']);
            if(isset($payload['publicationDate'])) $existing->setPublicationDate(new \DateTime($payload['publicationDate']));
            if(isset($payload['type'])) $existing->setType($payload['type']);
            if(isset($payload['edition'])) $existing->setEdition((int)$payload['edition'] ?? 1);
            if(isset($payload['doi'])) $existing->setDoi($payload['doi']);
            if(isset($payload['abstract'])) $existing->setAbstract($payload['abstract']);
            if(isset($payload['keywords'])) $existing->setKeywords($payload['keywords']);
            if(isset($payload['indexation'])) $existing->setIndexation($payload['indexation']);
            if(isset($payload['magazine'])) $existing->setMagazine($payload['magazine']);
            if(isset($payload['area'])) $existing->setArea($payload['area']);

            echo json_encode([
                'success' => $this->articleRepository->update($existing),
            ]);
            return;
        }

        if ($method === 'DELETE') {
            echo json_encode(['success' => $this->articleRepository->delete((int)$payload['id'] ?? 0)]);
            return;
        }
    }

    public function articleToArray(Article $article): array {
        return [
            'id' => $article->getId(),
            'title' => $article->getTitle(),
            'description' => $article->getDescription(),
            'publicationDate' => $article->getPublicationDate()->format('Y-m-d'),
            'author' => [
                'id' => $article->getAuthor()->getId(),
                'firstName' => $article->getAuthor()->getFirstName(),
                'lastName' => $article->getAuthor()->getLastName(),
            ],
            'type' => $article->getType(),
            'edition' => $article->getEdition(),
            'doi' => $article->getDoi(),
            'abstract' => $article->getAbstract(),
            'keywords' => $article->getKeywords(),
            'indexation' => $article->getIndexation(),
            'magazine' => $article->getMagazine(),
            'area' => $article->getArea()
        ];
    }
}
