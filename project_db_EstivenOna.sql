-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: project_db
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `publication_id` int NOT NULL AUTO_INCREMENT,
  `edition` int NOT NULL,
  `doi` varchar(20) NOT NULL,
  `abstract` varchar(300) NOT NULL,
  `keywords` varchar(50) NOT NULL,
  `indexation` varchar(50) NOT NULL,
  `magazine` varchar(50) NOT NULL,
  `area` varchar(50) NOT NULL,
  PRIMARY KEY (`publication_id`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`publication_id`) REFERENCES `publication` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (2,1,'10.1000/xyz.2024.01','Este artículo explora los últimos avances en robótica autónoma, enfocándose en la navegación y la toma de decisiones en entornos complejos.','robótica, autonomía, navegación, IA','Scopus','Revista de Robótica Aplicada','Ingeniería'),(4,2,'10.2000/abc.2023.02','Investigación detallada sobre las vulnerabilidades de seguridad en dispositivos IoT y estrategias de mitigación.','IoT, ciberseguridad, vulnerabilidades, redes','Web of Science','Journal of Cybersecurity','Informática'),(6,1,'10.3000/def.2024.03','Análisis de nuevas cepas bacterianas resistentes a antibióticos comunes y posibles soluciones.','bacterias, resistencia, antibióticos, salud','PubMed','Revista de Microbiología','Biología'),(8,3,'10.4000/ghi.2023.04','Estudio sobre cómo la globalización ha afectado los patrones de empleo y la distribución de la riqueza a nivel mundial.','globalización, empleo, economía, mercado laboral','Latindex','Cuadernos de Economía','Economía'),(10,1,'10.5000/jkl.2024.05','Exploración del impacto transformador del Big Data en la medicina y la investigación de la salud pública.','Big Data, salud, medicina, investigación','Scopus','Revista de Salud Digital','Ciencias de la Salud'),(12,1,'10.6000/mno.2023.06','Análisis de nuevas aproximaciones para mejorar la eficiencia de los algoritmos genéticos en problemas complejos.','algoritmos, optimización, IA, computación','IEEE Xplore','Revista de Computación Inteligente','Informática');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `orcid` varchar(20) NOT NULL,
  `afiliation` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Ana','García','anagarcia','ana.garcia@example.com','hashedpass123','0000-0001-2345-6789','Universidad Nacional'),(2,'Carlos','Martínez','carlosm','carlos.martinez@example.com','securepass456','0000-0002-3456-7890','Instituto de Tecnología Avanzada'),(3,'Laura','Pérez','laurap','laura.perez@example.com','mypasword789','0000-0003-4567-8901','Centro de Investigaciones Científicas'),(4,'David','Sánchez','davids','david.sanchez@example.com','strongpass010','0000-0004-5678-9012','Universidad Autónoma'),(5,'Elena','Ruiz','elenar','elena.ruiz@example.com','elenaP@ssW0rd','0000-0005-6789-0123','Universidad Andina Simón Bolívar'),(6,'Fernando','Torres','fertorres','fernando.torres@example.com','f3rN@nd0P@ss','0000-0006-7890-1234','Escuela Politécnica Nacional'),(7,'Ana','García','anagarcia','ana.garcia@example.com','hashedpass123','0000-0001-2345-6789','Universidad Nacional'),(8,'Carlos','Martínez','carlosm','carlos.martinez@example.com','securepass456','0000-0002-3456-7890','Instituto de Tecnología Avanzada'),(9,'Laura','Pérez','laurap','laura.perez@example.com','mypasword789','0000-0003-4567-8901','Centro de Investigaciones Científicas'),(10,'David','Sánchez','davids','david.sanchez@example.com','strongpass010','0000-0004-5678-9012','Universidad Autónoma'),(11,'Elena','Ruiz','elenar','elena.ruiz@example.com','elenaP@ssW0rd','0000-0005-6789-0123','Universidad Andina Simón Bolívar'),(12,'Fernando','Torres','fertorres','fernando.torres@example.com','f3rN@nd0P@ss','0000-0006-7890-1234','Escuela Politécnica Nacional'),(13,'Ana','García','anagarcia','ana.garcia@example.com','hashedpass123','0000-0001-2345-6789','Universidad Nacional'),(14,'Carlos','Martínez','carlosm','carlos.martinez@example.com','securepass456','0000-0002-3456-7890','Instituto de Tecnología Avanzada'),(15,'Laura','Pérez','laurap','laura.perez@example.com','mypasword789','0000-0003-4567-8901','Centro de Investigaciones Científicas'),(16,'David','Sánchez','davids','david.sanchez@example.com','strongpass010','0000-0004-5678-9012','Universidad Autónoma'),(17,'Elena','Ruiz','elenar','elena.ruiz@example.com','elenaP@ssW0rd','0000-0005-6789-0123','Universidad Andina Simón Bolívar'),(18,'Fernando','Torres','fertorres','fernando.torres@example.com','f3rN@nd0P@ss','0000-0006-7890-1234','Escuela Politécnica Nacional'),(21,'Sammy','Laurence','sammylaurence','sammybendydevoted@example.com','$2y$10$3h4xAWDeoQUfICO86NgKJuU7TTk48NcChh2ONazrjK3XMDnasngoa','0000-0000-0000-0000','Joey Drew Studios'),(25,'Sammy','Laurence','sammylaurence','sammybendydevoted@example.com','$2y$10$XF5FyhmCjYO4m0FqzXdp4el.EWjSYLIfW1NiVRJIypn8ljdUSgMMK','0000-0000-0000-0000','Joey Drew Studios'),(26,'Dulce','Campbell','campbellclaire','ccampbell@espe.edu.ec','$2y$10$r089o7yv9mWud/GEeJFdKe2hYgokhRL4vit3zYvM02xsrDNCcgPmm','0000-0001-2345-6123','ESPE'),(27,'Claire','Campbell','campbellclaire','ccampbell@espe.edu.ec','$2y$10$SDNaaQcweLnN5YmHe0yo7e3M3H6odcJkCvRe3GnbPBxYjyf7JYReS','0000-0001-2345-6123','ESPE');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `publication_id` int NOT NULL AUTO_INCREMENT,
  `isbn` varchar(20) NOT NULL,
  `genre` varchar(20) NOT NULL,
  `edition` int NOT NULL,
  PRIMARY KEY (`publication_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`publication_id`) REFERENCES `publication` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'978-3-16-148410-0','Ciencia Ficción',1),(3,'978-1-23-456789-7','Tecnología',2),(5,'978-0-12-345678-9','Ciencia',1),(7,'978-9-87-654321-0','Historia',3),(9,'978-8-76-543210-9','Informática',1),(11,'978-7-65-432109-8','Ingeniería',1),(39,'978-1-23456-789-7','Horror',1),(40,'978-1-23456-789-7','Horror',1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  `publication_date` date NOT NULL,
  `author_id` int NOT NULL,
  `type` enum('book','article') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication`
--

LOCK TABLES `publication` WRITE;
/*!40000 ALTER TABLE `publication` DISABLE KEYS */;
INSERT INTO `publication` VALUES (1,'Fundamentos de la Inteligencia Artificial','Un libro introductorio sobre IA y aprendizaje automático.','2023-01-15',1,'book'),(2,'Avances en Robótica Autónoma','Artículo sobre los últimos desarrollos en robótica móvil.','2024-03-20',1,'article'),(3,'Guía Completa de Ciberseguridad','Manual para proteger sistemas y redes de ataques.','2022-07-01',2,'book'),(4,'Análisis de Vulnerabilidades en IoT','Investigación sobre la seguridad de dispositivos conectados.','2023-11-10',2,'article'),(5,'Biología Molecular: Conceptos Clave','Texto fundamental para estudiantes de ciencias de la vida.','2021-09-05',3,'book'),(6,'Estudio sobre la Resistencia Bacteriana','Artículo científico sobre nuevas cepas resistentes a antibióticos.','2024-01-25',3,'article'),(7,'Historia Económica de América Latina','Análisis de los procesos económicos desde la colonia hasta hoy.','2020-04-10',4,'book'),(8,'Impacto de la Globalización en el Empleo','Artículo de investigación sobre tendencias laborales globales.','2023-06-01',4,'article'),(9,'Diseño de Bases de Datos Relacionales','Manual práctico para el diseño y optimización de bases de datos.','2023-09-01',5,'book'),(10,'La Importancia del Big Data en la Salud','Artículo sobre la aplicación de Big Data en la investigación médica.','2024-02-10',5,'article'),(11,'Ingeniería de Software: Métodos Ágiles','Libro sobre metodologías ágiles en el desarrollo de software.','2022-03-25',6,'book'),(12,'Optimización de Algoritmos Genéticos','Investigación sobre nuevas técnicas de optimización mediante algoritmos.','2023-08-15',6,'article'),(13,'Fundamentos de la Inteligencia Artificial','Un libro introductorio sobre IA y aprendizaje automático.','2023-01-15',1,'book'),(14,'Avances en Robótica Autónoma','Artículo sobre los últimos desarrollos en robótica móvil.','2024-03-20',1,'article'),(15,'Guía Completa de Ciberseguridad','Manual para proteger sistemas y redes de ataques.','2022-07-01',2,'book'),(16,'Análisis de Vulnerabilidades en IoT','Investigación sobre la seguridad de dispositivos conectados.','2023-11-10',2,'article'),(17,'Biología Molecular: Conceptos Clave','Texto fundamental para estudiantes de ciencias de la vida.','2021-09-05',3,'book'),(18,'Estudio sobre la Resistencia Bacteriana','Artículo científico sobre nuevas cepas resistentes a antibióticos.','2024-01-25',3,'article'),(19,'Historia Económica de América Latina','Análisis de los procesos económicos desde la colonia hasta hoy.','2020-04-10',4,'book'),(20,'Impacto de la Globalización en el Empleo','Artículo de investigación sobre tendencias laborales globales.','2023-06-01',4,'article'),(21,'Diseño de Bases de Datos Relacionales','Manual práctico para el diseño y optimización de bases de datos.','2023-09-01',5,'book'),(22,'La Importancia del Big Data en la Salud','Artículo sobre la aplicación de Big Data en la investigación médica.','2024-02-10',5,'article'),(23,'Ingeniería de Software: Métodos Ágiles','Libro sobre metodologías ágiles en el desarrollo de software.','2022-03-25',6,'book'),(24,'Optimización de Algoritmos Genéticos','Investigación sobre nuevas técnicas de optimización mediante algoritmos.','2023-08-15',6,'article'),(25,'Fundamentos de la Inteligencia Artificial','Un libro introductorio sobre IA y aprendizaje automático.','2023-01-15',1,'book'),(26,'Avances en Robótica Autónoma','Artículo sobre los últimos desarrollos en robótica móvil.','2024-03-20',1,'article'),(27,'Guía Completa de Ciberseguridad','Manual para proteger sistemas y redes de ataques.','2022-07-01',2,'book'),(28,'Análisis de Vulnerabilidades en IoT','Investigación sobre la seguridad de dispositivos conectados.','2023-11-10',2,'article'),(29,'Biología Molecular: Conceptos Clave','Texto fundamental para estudiantes de ciencias de la vida.','2021-09-05',3,'book'),(30,'Estudio sobre la Resistencia Bacteriana','Artículo científico sobre nuevas cepas resistentes a antibióticos.','2024-01-25',3,'article'),(31,'Historia Económica de América Latina','Análisis de los procesos económicos desde la colonia hasta hoy.','2020-04-10',4,'book'),(32,'Impacto de la Globalización en el Empleo','Artículo de investigación sobre tendencias laborales globales.','2023-06-01',4,'article'),(33,'Diseño de Bases de Datos Relacionales','Manual práctico para el diseño y optimización de bases de datos.','2023-09-01',5,'book'),(34,'La Importancia del Big Data en la Salud','Artículo sobre la aplicación de Big Data en la investigación médica.','2024-02-10',5,'article'),(35,'Ingeniería de Software: Métodos Ágiles','Libro sobre metodologías ágiles en el desarrollo de software.','2022-03-25',6,'book'),(36,'Optimización de Algoritmos Genéticos','Investigación sobre nuevas técnicas de optimización mediante algoritmos.','2023-08-15',6,'article'),(39,'Bendy and the Ink Machine','A horror game about a cartoon studio','2023-10-01',25,'book'),(40,'Bendy and the Ink Machine','A horror game about a cartoon studio','2023-10-01',26,'book');
/*!40000 ALTER TABLE `publication` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-05 19:03:23
