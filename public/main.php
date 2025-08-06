<?php

declare (strict_types=1);

require_once __DIR__ . '/../vendor/autoload.php';

use App\repositories\BookRepository;
use App\repositories\AuthorRepository;

//probamos el repositorio de libros el findAll
$bookRepository = new BookRepository();
$books = $bookRepository->findAll();
foreach ($books as $book) {
    echo "Book ID: " . $book->getId() . ", Title: " . $book->getTitle() . "\n";
}
//probamos el repositorio de autores el findAll
$authorRepository = new AuthorRepository();
$authors = $authorRepository->findAll();
foreach ($authors as $author) {
    echo "Author ID: " . $author->getId() . ", Name: " . $author->getFirstName() . " " . $author->getLastName() . "\n";
}
//añadir un autor
$sammyAuthorEntity = new \App\entities\Author(
    0,
    'Sammy',
    'Laurence',
    'sammylaurence',
    'sammybendydevoted@example.com',
    'bendyforever',
    '0000-0000-0000-0000',
    'Joey Drew Studios'
);
$authorRepo = new AuthorRepository();
echo "Author ID before creation: " . $sammyAuthorEntity->getId() . "\n";
$authorCreated = $authorRepo->create($sammyAuthorEntity);

if ($authorCreated) {
    echo "Author created successfully! New ID: " . $sammyAuthorEntity->getId() . "\n";
} else {
    echo "Failed to create author\n";
}

//añadimos un libro que sea de este autor xd, la función actualizada en BookRepository.php
// public function create(object $entity): bool {
//         if (!$entity instanceof Book) {
//             throw new \InvalidArgumentException("Book expected, bobaso");
//         }

//         $stmt = $this->db->prepare("CALL sp_create_book(:t,:d,:dt,:aid,:i,:g,:ed");
//         $ok = $stmt->execute([
//             ':t' => $entity->getTitle(),
//             ':d' => $entity->getDescription(),
//             ':dt' => $entity->getPublicationDate()->format('Y-m-d'),
//             ':aid' => $entity->getAuthor()->getId(),
//             ':i' => $entity->getIsbn(),
//             ':g' => $entity->getGenre(),
//             ':ed' => $entity->getEdition()
//         ]);
//         if ($ok) {
//             $stmt->fetch();
//         }
//         $stmt->closeCursor();
//         return $ok;
//     }

$bookEntity = new \App\entities\Book(
    0,
    'Bendy and the Ink Machine',
    'A horror game about a cartoon studio',
    new \DateTime('2023-10-01'),
    $sammyAuthorEntity,
    '978-1-23456-789-7',
    'Horror',
    1
);

echo "Attempting to create book with author ID: " . $sammyAuthorEntity->getId() . "\n";
$bookCreated = $bookRepository->create($bookEntity);

if ($bookCreated) {
    echo "Book created successfully!\n";
} else {
    echo "Failed to create book\n";
}

// Verificar que el libro se creó listando todos los libros
echo "\n--- Final book list ---\n";
$allBooks = $bookRepository->findAll();
foreach ($allBooks as $book) {
    echo "Book ID: " . $book->getId() . ", Title: " . $book->getTitle() . ", Author: " . $book->getAuthor()->getFirstName() . " " . $book->getAuthor()->getLastName() . "\n";
}