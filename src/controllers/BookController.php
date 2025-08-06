<?php

declare(strict_types=1);

namespace App\controllers;

use App\repositories\BookRepository;
use App\repositories\AuthorRepository;
use App\entities\Book;
use App\entities\Author;

class BookController {
    private BookRepository $bookRepository;
    private AuthorRepository $authorRepository;

    public function __construct() {
        $this->bookRepository = new BookRepository();
        $this->authorRepository = new AuthorRepository();
    }

    public function handle(): void {
        header('Content-Type: application/json');
        $method = $_SERVER['REQUEST_METHOD'];

        if (isset($_GET['id'])) {
            $book = $this->bookRepository->findById((int) $_GET['id']);
            echo json_encode($book ? $this->bookToArray($book) : null);
            return;
        } else {
            $list = array_map(
                [$this,'bookToArray'], 
                $this->bookRepository->findAll()
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

            $book = new Book(
                0,
                $payload['title'],
                $payload['description'],
                new \DateTime($payload['publicationDate'] ?? 'now'),
                $author,
                $payload['isbn'],
                $payload['genre'],
                (int)$payload['edition'] ?? 1
            );

            echo json_encode([
                'success' => $this->bookRepository->create($book),
            ]);
            return;
        }

        if ($method === 'PUT') {
            $id = (int)($payload['id'] ?? 0);
            $existing = $this->bookRepository->findById($id);
            if (!$existing) {
                http_response_code(404);
                echo json_encode(['error' => 'Book not found']);
                return;
            }

            if (isset($payload['authorId'])) {
                $author = $this->authorRepository->findById((int)$payload['authorId'] ?? 0);
                if ($author) $existing->setAuthor($author);
            }

            if(isset($payload['title'])) $existing->setTitle($payload['title']);
            if(isset($payload['description'])) $existing->setDescription($payload['description']);
            if(isset($payload['publicationDate'])) $existing->setPublicationDate(new \DateTime($payload['publicationDate']));
            if(isset($payload['isbn'])) $existing->setIsbn($payload['isbn']);
            if(isset($payload['genre'])) $existing->setGenre($payload['genre']);
            if(isset($payload['edition'])) $existing->setEdition((int)$payload['edition'] ?? 1);

            echo json_encode([
                'success' => $this->bookRepository->update($existing),
            ]);
        }

        if ($method === 'DELETE') {
            echo json_encode(['success' => $this->bookRepository->delete((int)$payload['id'] ?? 0)]);
            return;
        }
    }

    public function bookToArray(Book $book):array {
        return [
            'id' => $book->getId(),
            'title' => $book->getTitle(),
            'description' => $book->getDescription(),
            'publicationDate' => $book->getPublicationDate()->format('Y-m-d'),
            'author' => [
                'id' => $book->getAuthor()->getId(),
                'firstName' => $book->getAuthor()->getFirstName(),
                'lastName' => $book->getAuthor()->getLastName(),
            ],
            'isbn' => $book->getIsbn(),
            'genre' => $book->getGenre(),
            'edition' => $book->getEdition()
        ];
    }
}

