<?php

declare(strict_types=1);

namespace App\controllers;

use App\repositories\AuthorRepository;
use App\entities\Author;

class AuthorController {
    private AuthorRepository $authorRepository;

    public function __construct() {
        $this->authorRepository = new AuthorRepository();
    }

    public function handle(): void {
        header('Content-Type: application/json');
        $method = $_SERVER['REQUEST_METHOD'];

        if (isset($_GET['id'])) {
            $author = $this->authorRepository->findById((int) $_GET['id']);
            echo json_encode($author ? $this->authorToArray($author) : null);
            return;
        } else {
            $list = array_map(
                [$this,'authorToArray'], 
                $this->authorRepository->findAll()
            );
            echo json_encode($list);
        }

        $payload = json_decode(file_get_contents('php://input'), true);

        if ($method === 'POST') {
            $author = new Author(
                0,
                $payload['firstName'],
                $payload['lastName'],
                $payload['username'],
                $payload['email'],
                $payload['password'],
                $payload['orcid'],
                $payload['afiliation']
            );

            echo json_encode([
                'success' => $this->authorRepository->create($author),
            ]);
            return;
        }

        if ($method === 'PUT') {
            $id = (int)($payload['id'] ?? 0);
            $existing = $this->authorRepository->findById($id);
            if (!$existing) {
                http_response_code(404);
                echo json_encode(['error' => 'Author not found']);
                return;
            }

            if(isset($payload['firstName'])) $existing->setFirstName($payload['firstName']);
            if(isset($payload['lastName'])) $existing->setLastName($payload['lastName']);
            if(isset($payload['username'])) $existing->setUsername($payload['username']);
            if(isset($payload['email'])) $existing->setEmail($payload['email']);
            if(isset($payload['password'])) $existing->setPassword($payload['password']);
            if(isset($payload['orcid'])) $existing->setOrcid($payload['orcid']);
            if(isset($payload['afiliation'])) $existing->setAfiliation($payload['afiliation']);

            echo json_encode([
                'success' => $this->authorRepository->update($existing),
            ]);
            return;
        }

        if ($method === 'DELETE') {
            echo json_encode(['success' => $this->authorRepository->delete((int)$payload['id'] ?? 0)]);
            return;
        }
    }

    public function authorToArray(Author $author): array {
        return [
            'id' => $author->getId(),
            'firstName' => $author->getFirstName(),
            'lastName' => $author->getLastName(),
            'username' => $author->getUsername(),
            'email' => $author->getEmail(),
            'password' => $author->getPassword(),
            'orcid' => $author->getOrcid(),
            'afiliation' => $author->getAfiliation()
        ];
    }
}
