<?php
declare(strict_types=1);

namespace App\entities;
/*
* DB REFERENCE PUBLICATION TABLE
CREATE TABLE publication (
    id int AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100) NOT NULL,
    publication_date DATE NOT NULL,
    author_id int NOT NULL,
    type ENUM('book','article') NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author(id)
        ON DELETE CASCADE
);
*/

abstract class Publication {
    protected int $id;
    protected string $title;
    protected string $description;
    protected \DateTime $publicationDate;
    protected Author $author;
    protected string $type;
    public function __construct(
        int $id,
        string $title,
        string $description,
        \DateTime $publicationDate,
        Author $author,
        string $type
    ) {
        $this->id = $id;
        $this->title = $title;
        $this->description = $description;
        $this->publicationDate = $publicationDate;
        $this->author = $author;
        $this->type = $type;
    }

    // Getters
    public function getId(): int {
        return $this->id;
    }
    public function getTitle(): string {
        return $this->title;
    }

    public function getDescription(): string {
        return $this->description;
    }

    public function getPublicationDate(): \DateTime {
        return $this->publicationDate;
    }

    public function getAuthor(): Author {
        return $this->author;
    }

    public function getType(): string {
        return $this->type;
    }
    // Setters
    public function setTitle(string $title): void {
        $this->title = $title;
    }
    public function setDescription(string $description): void {
        $this->description = $description;
    }
    public function setPublicationDate(\DateTime $publicationDate): void {
        $this->publicationDate = $publicationDate;
    }
    public function setAuthor(Author $author): void {
        $this->author = $author;
    }
    public function setType(string $type): void {
        $this->type = $type;
    }

}