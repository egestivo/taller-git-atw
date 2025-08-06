<?php

declare (strict_types=1);
namespace App\repositories;

use App\interfaces\RepositoryInterface;
use App\config\Database;
use App\entities\Author;
use PDO;

class AuthorRepository implements RepositoryInterface {
    private PDO $db;

    public function __construct() {
        $this->db = Database::getConnection();
    }

    public function findAll(): array {
        $stmt = $this->db->query("SELECT * FROM author");
        $list = [];
        while ($row = $stmt->fetch()) {
            $list[] = $this->hydrate($row); //row -> fila sql
        }
        return $list;
    }

    public function findById(int $id): ?Author {
        $stmt = $this->db->prepare("CALL sp_find_author(:id)");
        $stmt->execute([':id' => $id]);
        $row = $stmt->fetch();
        $stmt->closeCursor();
        return $row ? $this->hydrate($row) : null;
    }

    public function create (object $entity): bool{
        if (!$entity instanceof Author) {
            throw new \InvalidArgumentException("Author expected, bobaso");
        }

        $sql = "CALL sp_create_author(:fn, :ln, :usrn, :email, :passwd, :orcid, :afi)";
        $stmt = $this->db->prepare($sql);
        

        $result = $stmt->execute([
            ':fn' => $entity->getFirstName(),
            ':ln' => $entity->getLastName(),
            ':usrn' => $entity->getUsername(),
            ':email' => $entity->getEmail(),
            ':passwd' => $entity->getPassword(),
            ':orcid' => $entity->getOrcid(),
            ':afi' => $entity->getAfiliation()
        ]);

        if ($result) {
            $entity->setId((int)$this->db->lastInsertId());
        }
        return $result;
    }

    public function update(object $entity): bool {
        if (!$entity instanceof Author) {
            throw new \InvalidArgumentException("Author expected, bobaso");
        }

        $stmt = $this->db->prepare("CALL sp_update_author(:id, :fn, :ln, :un, :email, :passwd, :orcid, :afi)");
        return $stmt->execute([
            ':id' => $entity->getId(),
            ':fn' => $entity->getFirstName(),
            ':ln' => $entity->getLastName(),
            ':un' => $entity->getUsername(),
            ':email' => $entity->getEmail(),
            ':passwd' => $entity->getPassword(),
            ':orcid' => $entity->getOrcid(),
            ':afi' => $entity->getAfiliation(),
        ]);
    }

    public function delete(int $id): bool {
        $sql = "Call sp_delete_author(:id)";
        $stmt = $this->db->prepare($sql);
        return $stmt->execute([':id' => $id]);
    }

    //convierte una fila SQL a un objeto PHP
    private function hydrate(array $row): Author {
        $author = new Author(
            (int)$row['id'],
            $row['first_name'],
            $row['last_name'],
            $row['username'],
            $row['email'],
            'temporal',
            $row['orcid'],
            $row['afiliation']
        );

        $ref = new \ReflectionClass($author);
        $prop = $ref -> getProperty('password');
        $prop -> setAccessible(true);
        $prop -> setValue($author, $row['password']);

        return $author;
    }
}