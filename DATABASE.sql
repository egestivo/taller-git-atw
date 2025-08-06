CREATE TABLE author (
    id int AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    orcid VARCHAR(20) NOT NULL,
    afiliation VARCHAR(50) NOT NULL
);

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

CREATE TABLE book (
    publication_id int AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    edition int NOT NULL,
    FOREIGN KEY (publication_id) REFERENCES publication(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE article (
    publication_id int AUTO_INCREMENT PRIMARY KEY,
    edition int NOT NULL,
    doi VARCHAR(20) NOT NULL,
    abstract VARCHAR(300) NOT NULL,
    keywords VARCHAR(50) NOT NULL,
    indexation VARCHAR(50) NOT NULL,
    magazine VARCHAR(50) NOT NULL,
    area VARCHAR(50) NOT NULL,
    FOREIGN KEY (publication_id) REFERENCES publication(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Procedimientos almacenados para Article
DELIMITER //

-- Listar todos los artículos con información del autor
CREATE PROCEDURE sp_article_list()
BEGIN
    SELECT 
        a.publication_id,
        p.id,
        p.title,
        p.description,
        p.publication_date,
        p.type,
        a.edition,
        a.doi,
        a.abstract,
        a.keywords,
        a.indexation,
        a.magazine,
        a.area,
        au.id as author_id,
        au.first_name,
        au.last_name,
        au.username,
        au.email,
        au.orcid,
        au.afiliation
    FROM article a
    INNER JOIN publication p ON a.publication_id = p.id
    INNER JOIN author au ON p.author_id = au.id
    ORDER BY p.publication_date DESC;
END //

-- Buscar artículo por ID
CREATE PROCEDURE sp_article_find_by_id(IN article_id INT)
BEGIN
    SELECT 
        a.publication_id,
        p.id,
        p.title,
        p.description,
        p.publication_date,
        p.type,
        a.edition,
        a.doi,
        a.abstract,
        a.keywords,
        a.indexation,
        a.magazine,
        a.area,
        au.id as author_id,
        au.first_name,
        au.last_name,
        au.username,
        au.email,
        au.orcid,
        au.afiliation
    FROM article a
    INNER JOIN publication p ON a.publication_id = p.id
    INNER JOIN author au ON p.author_id = au.id
    WHERE a.publication_id = article_id;
END //

-- Crear nuevo artículo
CREATE PROCEDURE sp_create_article(
    IN p_title VARCHAR(100),
    IN p_description VARCHAR(100),
    IN p_publication_date DATE,
    IN p_author_id INT,
    IN p_edition INT,
    IN p_doi VARCHAR(20),
    IN p_abstract VARCHAR(300),
    IN p_keywords VARCHAR(50),
    IN p_indexation VARCHAR(50),
    IN p_magazine VARCHAR(50),
    IN p_area VARCHAR(50)
)
BEGIN
    DECLARE publication_id INT;
    
    -- Insertar en la tabla publication
    INSERT INTO publication (title, description, publication_date, author_id, type)
    VALUES (p_title, p_description, p_publication_date, p_author_id, 'article');
    
    -- Obtener el ID de la publicación recién creada
    SET publication_id = LAST_INSERT_ID();
    
    -- Insertar en la tabla article
    INSERT INTO article (publication_id, edition, doi, abstract, keywords, indexation, magazine, area)
    VALUES (publication_id, p_edition, p_doi, p_abstract, p_keywords, p_indexation, p_magazine, p_area);
    
    SELECT publication_id as created_id;
END //

-- Actualizar artículo
CREATE PROCEDURE sp_update_article(
    IN p_id INT,
    IN p_title VARCHAR(100),
    IN p_description VARCHAR(100),
    IN p_publication_date DATE,
    IN p_author_id INT,
    IN p_edition INT,
    IN p_doi VARCHAR(20),
    IN p_abstract VARCHAR(300),
    IN p_keywords VARCHAR(50),
    IN p_indexation VARCHAR(50),
    IN p_magazine VARCHAR(50),
    IN p_area VARCHAR(50)
)
BEGIN
    -- Actualizar la tabla publication
    UPDATE publication 
    SET title = p_title,
        description = p_description,
        publication_date = p_publication_date,
        author_id = p_author_id
    WHERE id = p_id;
    
    -- Actualizar la tabla article
    UPDATE article 
    SET edition = p_edition,
        doi = p_doi,
        abstract = p_abstract,
        keywords = p_keywords,
        indexation = p_indexation,
        magazine = p_magazine,
        area = p_area
    WHERE publication_id = p_id;
    
    SELECT ROW_COUNT() as affected_rows;
END //

-- Eliminar artículo
CREATE PROCEDURE sp_delete_article(IN article_id INT)
BEGIN
    -- Al eliminar de publication, article se elimina automáticamente por CASCADE
    DELETE FROM publication WHERE id = article_id;
    SELECT ROW_COUNT() as affected_rows;
END //

-- Procedimientos almacenados para Author
-- Listar todos los autores
CREATE PROCEDURE sp_author_list()
BEGIN
    SELECT 
        id,
        first_name,
        last_name,
        username,
        email,
        password,
        orcid,
        afiliation
    FROM author
    ORDER BY last_name, first_name;
END //

-- Buscar autor por ID
CREATE PROCEDURE sp_author_find_by_id(IN author_id INT)
BEGIN
    SELECT 
        id,
        first_name,
        last_name,
        username,
        email,
        password,
        orcid,
        afiliation
    FROM author 
    WHERE id = author_id;
END //

-- Crear nuevo autor
CREATE PROCEDURE sp_create_author(
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_orcid VARCHAR(20),
    IN p_afiliation VARCHAR(50)
)
BEGIN
    INSERT INTO author (first_name, last_name, username, email, password, orcid, afiliation)
    VALUES (p_first_name, p_last_name, p_username, p_email, p_password, p_orcid, p_afiliation);
    
    SELECT LAST_INSERT_ID() as created_id;
END //

-- Actualizar autor
CREATE PROCEDURE sp_update_author(
    IN p_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password VARCHAR(100),
    IN p_orcid VARCHAR(20),
    IN p_afiliation VARCHAR(50)
)
BEGIN
    UPDATE author 
    SET first_name = p_first_name,
        last_name = p_last_name,
        username = p_username,
        email = p_email,
        password = p_password,
        orcid = p_orcid,
        afiliation = p_afiliation
    WHERE id = p_id;
    
    SELECT ROW_COUNT() as affected_rows;
END //

-- Eliminar autor
CREATE PROCEDURE sp_delete_author(IN author_id INT)
BEGIN
    -- Al eliminar autor, se eliminan automáticamente sus publicaciones por CASCADE
    DELETE FROM author WHERE id = author_id;
    SELECT ROW_COUNT() as affected_rows;
END //

DELIMITER ;

