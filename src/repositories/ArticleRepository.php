<?php

declare (strict_types=1);
namespace App\repositories;

use App\interfaces\RepositoryInterface;
use App\config\Database;
use App\entities\Article;
use App\entities\Author;
use PDO;

class ArticleRepository implements RepositoryInterface {
    private PDO $db;
    private AuthorRepository $authorRepository;

    public function __construct() {
        $this->db = Database::getConnection();
        $this->authorRepository = new AuthorRepository();
    }

    public function findAll(): array {
        $stmt = $this->db->query("CALL sp_article_list();");
        $rows = $stmt->fetchAll();
        $stmt->closeCursor();
        $out = [];
        foreach ($rows as $row) {
            $out[] = $this->hydrate($row);
        }
        return $out;
    }

    public function findById(int $id): ?Article {
        $stmt = $this->db->prepare("CALL sp_article_find_by_id(:id)");
        $stmt->execute([':id' => $id]);
        $row = $stmt->fetch();
        $stmt->closeCursor();
        return $row ? $this->hydrate($row) : null;
    }

    public function create(object $entity): bool {
        if (!$entity instanceof Article) {
            throw new \InvalidArgumentException("Article expected, bobaso");
        }

        $stmt = $this->db->prepare("CALL sp_create_article(:t,:d,:dt,:aid,:ed,:doi,:abs,:kw,:idx,:mag,:area)");
        $ok = $stmt->execute([
            ':t' => $entity->getTitle(),
            ':d' => $entity->getDescription(),
            ':dt' => $entity->getPublicationDate()->format('Y-m-d'),
            ':aid' => $entity->getAuthor()->getId(),
            ':ed' => $entity->getEdition(),
            ':doi' => $entity->getDoi(),
            ':abs' => $entity->getAbstract(),
            ':kw' => $entity->getKeywords(),
            ':idx' => $entity->getIndexation(),
            ':mag' => $entity->getMagazine(),
            ':area' => $entity->getArea()
        ]);
        if ($ok) {
            $stmt->fetch();
        }
        $stmt->closeCursor();
        return $ok;
    }

    public function update(object $entity): bool {
        if (!$entity instanceof Article) {
            throw new \InvalidArgumentException("Article expected");
        }

        $stmt = $this->db->prepare("CALL sp_update_article(:id, :t, :d, :dt, :aid, :ed, :doi, :abs, :kw, :idx, :mag, :area)");
        $ok = $stmt->execute([
            ':id' => $entity->getId(),
            ':t' => $entity->getTitle(),
            ':d' => $entity->getDescription(),
            ':dt' => $entity->getPublicationDate()->format('Y-m-d'),
            ':aid' => $entity->getAuthor()->getId(),
            ':ed' => $entity->getEdition(),
            ':doi' => $entity->getDoi(),
            ':abs' => $entity->getAbstract(),
            ':kw' => $entity->getKeywords(),
            ':idx' => $entity->getIndexation(),
            ':mag' => $entity->getMagazine(),
            ':area' => $entity->getArea()
        ]);
        if ($ok) {
            $stmt->fetch();
        }
        $stmt->closeCursor();
        return $ok;
    }

    public function delete(int $id): bool {
        $stmt = $this->db->prepare("CALL sp_delete_article(:id)");
        $ok = $stmt->execute([':id' => $id]);
        if ($ok) {
            $stmt->fetch();
        }
        $stmt->closeCursor();
        return $ok;
    }

    private function hydrate(array $row): Article {
        $autor = new Author(
            (int)$row['author_id'],
            $row['first_name'],
            $row['last_name'],
            $row['username'],
            $row['email'],
            '',
            $row['orcid'],
            $row['afiliation']
        );
        
        return new Article(
            (int)$row['publication_id'],
            $row['title'],
            $row['description'],
            new \DateTime($row['publication_date']),
            $autor,
            'article',
            (int)$row['edition'],
            $row['doi'],
            $row['abstract'],
            $row['keywords'],
            $row['indexation'],
            $row['magazine'],
            $row['area']
        );
    }
}
