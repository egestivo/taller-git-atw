<?php
declare (strict_types=1);
namespace App\entities;

/*
CREATE TABLE book (
    publication_id int AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    edition int NOT NULL,
    FOREIGN KEY (publication_id) REFERENCES publication(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
*/

//extiende de Publication
class Book extends Publication {
    private string $isbn;
    private string $genre;
    private int $edition;

    public function __construct(
        int $id,
        string $title,
        string $description,
        \DateTime $publicationDate,
        Author $author,
        string $isbn,
        string $genre,
        int $edition
    ) {
        parent::__construct($id, $title, $description, $publicationDate, $author, $type='book');
        $this->isbn = $isbn;
        $this->genre = $genre;
        $this->edition = $edition;
    }

    //Getters
    public function getIsbn(): string {
        return $this->isbn;
    }
    public function getGenre(): string {
        return $this->genre;
    }
    public function getEdition(): int {
        return $this->edition;
    }
    //Setters
    public function setIsbn(string $isbn): void {
        $this->isbn = $isbn;
    }
    public function setGenre(string $genre): void {
        $this->genre = $genre;
    }
    public function setEdition(int $edition): void {
        $this->edition = $edition;
    }
}