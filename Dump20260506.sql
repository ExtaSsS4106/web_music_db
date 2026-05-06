CREATE DATABASE  IF NOT EXISTS `wm` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `wm`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: wm
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `albums`
--

DROP TABLE IF EXISTS `albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `authors_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albums_authors1_idx` (`authors_id`),
  CONSTRAINT `fk_albums_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audiofiles`
--

DROP TABLE IF EXISTS `audiofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audiofiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `code_name` varchar(255) NOT NULL,
  `full_title` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  `gif` varchar(255) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `albums_id` int NOT NULL,
  `listens` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_audiofiles_albums1_idx` (`albums_id`),
  CONSTRAINT `fk_audiofiles_albums1` FOREIGN KEY (`albums_id`) REFERENCES `albums` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `authors_statistics`
--

DROP TABLE IF EXISTS `authors_statistics`;
/*!50001 DROP VIEW IF EXISTS `authors_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `authors_statistics` AS SELECT 
 1 AS `author_id`,
 1 AS `author_name`,
 1 AS `author_logo`,
 1 AS `albums_count`,
 1 AS `tracks_count`,
 1 AS `total_listens`,
 1 AS `total_listens_function`,
 1 AS `popularity_rank`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `favoritealbums`
--

DROP TABLE IF EXISTS `favoritealbums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritealbums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `albums_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoritealbums_albums1_idx` (`albums_id`),
  KEY `fk_favoritealbums_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoritealbums_albums1` FOREIGN KEY (`albums_id`) REFERENCES `albums` (`id`),
  CONSTRAINT `fk_favoritealbums_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favoriteauthors`
--

DROP TABLE IF EXISTS `favoriteauthors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoriteauthors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `authors_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoriteauthors_authors1_idx` (`authors_id`),
  KEY `fk_favoriteauthors_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoriteauthors_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`),
  CONSTRAINT `fk_favoriteauthors_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favoritemusics`
--

DROP TABLE IF EXISTS `favoritemusics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritemusics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoritemusics_audiofiles1_idx` (`audiofiles_id`),
  KEY `fk_favoritemusics_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoritemusics_audiofiles1` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`),
  CONSTRAINT `fk_favoritemusics_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `last_usr_track`
--

DROP TABLE IF EXISTS `last_usr_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `last_usr_track` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_last_usr_track_audiofiles1_idx` (`audiofiles_id`),
  KEY `fk_last_usr_track_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_last_usr_track_audiofiles1` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`),
  CONSTRAINT `fk_last_usr_track_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prof_authors`
--

DROP TABLE IF EXISTS `prof_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prof_authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profiles_id` int NOT NULL,
  `authors_id` int NOT NULL,
  PRIMARY KEY (`id`,`profiles_id`,`authors_id`),
  KEY `fk_prof_authors_profiles1_idx` (`profiles_id`),
  KEY `fk_prof_authors_authors1_idx` (`authors_id`),
  CONSTRAINT `fk_prof_authors_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`),
  CONSTRAINT `fk_prof_authors_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profiles_users` (`users_id`),
  KEY `fk_profiles_roles_idx` (`role_id`),
  CONSTRAINT `fk_profiles_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `fk_profiles_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `create_author` AFTER INSERT ON `profiles` FOR EACH ROW BEGIN
	DECLARE new_author_id INT;
   DECLARE user_name varchar(255);
   select name into user_name from users where id = NEW.users_id;
   IF NEW.role_id = 2 THEN
      insert into authors (name) values (user_name);
      SET new_author_id = LAST_INSERT_ID();
      insert into prof_authors (`profiles_id`,`authors_id`) values (NEW.id, new_author_id);
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `switch_to_author` AFTER UPDATE ON `profiles` FOR EACH ROW BEGIN
    DECLARE new_author_id INT;
    DECLARE user_name VARCHAR(255);
    
    -- Проверяем, что роль изменилась именно на role_id = 2
    -- и что ранее она не была равна 2 (чтобы не дублировать)
    IF NEW.role_id = 2 AND (OLD.role_id != 2 OR OLD.role_id IS NULL) THEN
        
        -- Получаем имя пользователя
        SELECT name INTO user_name 
        FROM users 
        WHERE id = NEW.users_id;
        
        -- Создаем нового автора
        INSERT INTO authors (name) VALUES (user_name);
        SET new_author_id = LAST_INSERT_ID();
        
        -- Связываем профиль с автором
        INSERT INTO prof_authors (profiles_id, authors_id) 
        VALUES (NEW.id, new_author_id);
        
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profiles_albums`
--

DROP TABLE IF EXISTS `profiles_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles_albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(45) DEFAULT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profiles_albums_idx` (`profiles_id`),
  CONSTRAINT `fk_profiles_albums` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles_albums_tracks`
--

DROP TABLE IF EXISTS `profiles_albums_tracks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles_albums_tracks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `albums_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albums_idx` (`albums_id`),
  KEY `fk_audios_idx` (`audiofiles_id`),
  CONSTRAINT `fk_albums` FOREIGN KEY (`albums_id`) REFERENCES `profiles_albums` (`id`),
  CONSTRAINT `fk_audios` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `tracks_details`
--

DROP TABLE IF EXISTS `tracks_details`;
/*!50001 DROP VIEW IF EXISTS `tracks_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tracks_details` AS SELECT 
 1 AS `audio_id`,
 1 AS `title`,
 1 AS `code_name`,
 1 AS `full_title`,
 1 AS `img`,
 1 AS `url`,
 1 AS `file`,
 1 AS `gif`,
 1 AS `category`,
 1 AS `listens`,
 1 AS `albums_id`,
 1 AS `album_name`,
 1 AS `albums_logo`,
 1 AS `authors_id`,
 1 AS `authors_name`,
 1 AS `authors_logo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `user_categories_with_details`
--

DROP TABLE IF EXISTS `user_categories_with_details`;
/*!50001 DROP VIEW IF EXISTS `user_categories_with_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_categories_with_details` AS SELECT 
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `profile_id`,
 1 AS `category`,
 1 AS `favorite_count`,
 1 AS `percentage`,
 1 AS `category_rank`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `users_albums`
--

DROP TABLE IF EXISTS `users_albums`;
/*!50001 DROP VIEW IF EXISTS `users_albums`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `users_albums` AS SELECT 
 1 AS `audio_id`,
 1 AS `title`,
 1 AS `code_name`,
 1 AS `full_title`,
 1 AS `img`,
 1 AS `url`,
 1 AS `file`,
 1 AS `gif`,
 1 AS `category`,
 1 AS `listens`,
 1 AS `albums_id`,
 1 AS `album_name`,
 1 AS `albums_logo`,
 1 AS `profile_id`,
 1 AS `users_id`,
 1 AS `avatar`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `users_full_statistics`
--

DROP TABLE IF EXISTS `users_full_statistics`;
/*!50001 DROP VIEW IF EXISTS `users_full_statistics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `users_full_statistics` AS SELECT 
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `email`,
 1 AS `profile_id`,
 1 AS `avatar`,
 1 AS `role_name`,
 1 AS `favorite_tracks_count`,
 1 AS `favorite_authors_count`,
 1 AS `favorite_albums_count`,
 1 AS `listened_tracks_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'wm'
--

--
-- Dumping routines for database 'wm'
--
/*!50003 DROP FUNCTION IF EXISTS `get_author_total_listens` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_author_total_listens`(author_id INT) RETURNS bigint
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE total_listens BIGINT;
    
    SELECT COALESCE(SUM(audiofiles.listens), 0)
    INTO total_listens
    FROM audiofiles
    JOIN albums ON audiofiles.albums_id = albums.id
    WHERE albums.authors_id = author_id;
    
    RETURN total_listens;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_new_track` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_track`(
IN p_title VARCHAR(255),
IN p_code_name VARCHAR(255),
IN p_file  VARCHAR(255),
IN p_album_id INT,

IN p_full_title VARCHAR(255),
IN p_img  VARCHAR(255),
IN p_url  VARCHAR(45),
IN p_gif  VARCHAR(255),
IN p_category  VARCHAR(45)
)
BEGIN

	DECLARE v_code_name VARCHAR(255);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    
    
    IF p_title IS NULL OR p_title = '' OR
       p_file IS NULL OR p_file = '' OR
       p_album_id IS NULL OR p_album_id = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Required fields: title, file, album_id cannot be empty or null';
    END IF;
    
    IF p_code_name IS NULL OR p_code_name = '' THEN
        SET v_code_name = SUBSTRING(MD5(CONCAT(p_title, RAND(), NOW())), 1, 11);
        WHILE EXISTS (SELECT 1 FROM `audiofiles` WHERE code_name = v_code_name) DO
            SET v_code_name = SUBSTRING(MD5(CONCAT(RAND(), NOW())), 1, 11);
        END WHILE;
    ELSE
        IF EXISTS (SELECT 1 FROM `audiofiles` WHERE code_name = p_code_name) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Code name already exists';
        END IF;
        SET v_code_name = p_code_name;
    END IF;
    
    START TRANSACTION;
    INSERT INTO `audiofiles` (title, code_name, `file`, albums_id, full_title, img, url, gif, category) VALUES (p_title, v_code_name, p_file, p_album_id, p_full_title, p_img, p_url, p_gif, p_category);
    COMMIT;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_to_favorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_to_favorites`(
    IN p_audiofile_id INT,
    IN p_profile_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
   
    IF NOT EXISTS (
        SELECT 1 FROM favoritemusics 
        WHERE audiofiles_id = p_audiofile_id AND profiles_id = p_profile_id
    ) THEN
        INSERT INTO favoritemusics (audiofiles_id, profiles_id) 
        VALUES (p_audiofile_id, p_profile_id);
        SELECT 'Трек добавлен в избранное' AS message;
    ELSE
        SELECT 'Трек уже в избранном' AS message;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_user`(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_role int
)
BEGIN
declare name_count int;
declare email_count int;
declare new_user_id int;

select count(*) into name_count from users where name = p_name;
select count(*) into email_count from users where email = p_email;

IF p_name IS NULL OR p_name = '' OR 
       p_email IS NULL OR p_email = '' OR 
       p_password IS NULL OR p_password = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ошибка: необходимо заполнить все поля';
    END IF;
    


if name_count > 0 then
    SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'пользователь с таким именем уже есть';
    
elseif email_count > 0 then
    SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'пользователь с такой почтой уже есть';
    
else 
	insert into users (name, email, password)
	values(p_name, p_email ,p_password);
    SET new_user_id = LAST_INSERT_ID();
    insert into profiles (users_id, role_id)
	values(new_user_id, p_role);
end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `remove_from_favorites` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `remove_from_favorites`(
    IN p_audiofile_id INT,
    IN p_profile_id INT
)
BEGIN
    DELETE FROM favoritemusics 
    WHERE audiofiles_id = p_audiofile_id AND profiles_id = p_profile_id;
    
    SELECT CONCAT('Трек ', p_audiofile_id, ' удален из избранного') AS message;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `authors_statistics`
--

/*!50001 DROP VIEW IF EXISTS `authors_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `authors_statistics` AS select `a`.`id` AS `author_id`,`a`.`name` AS `author_name`,`a`.`logo` AS `author_logo`,count(distinct `alb`.`id`) AS `albums_count`,count(distinct `af`.`id`) AS `tracks_count`,coalesce(sum(`af`.`listens`),0) AS `total_listens`,`get_author_total_listens`(`a`.`id`) AS `total_listens_function`,dense_rank() OVER (ORDER BY coalesce(sum(`af`.`listens`),0) desc )  AS `popularity_rank` from ((`authors` `a` left join `albums` `alb` on((`a`.`id` = `alb`.`authors_id`))) left join `audiofiles` `af` on((`alb`.`id` = `af`.`albums_id`))) group by `a`.`id`,`a`.`name`,`a`.`logo` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tracks_details`
--

/*!50001 DROP VIEW IF EXISTS `tracks_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `tracks_details` AS select `audiofiles`.`id` AS `audio_id`,`audiofiles`.`title` AS `title`,`audiofiles`.`code_name` AS `code_name`,`audiofiles`.`full_title` AS `full_title`,`audiofiles`.`img` AS `img`,`audiofiles`.`url` AS `url`,`audiofiles`.`file` AS `file`,`audiofiles`.`gif` AS `gif`,`audiofiles`.`category` AS `category`,`audiofiles`.`listens` AS `listens`,`albums`.`id` AS `albums_id`,`albums`.`name` AS `album_name`,`albums`.`logo` AS `albums_logo`,`authors`.`id` AS `authors_id`,`authors`.`name` AS `authors_name`,`authors`.`logo` AS `authors_logo` from ((`audiofiles` join `albums` on((`audiofiles`.`albums_id` = `albums`.`id`))) join `authors` on((`albums`.`authors_id` = `authors`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_categories_with_details`
--

/*!50001 DROP VIEW IF EXISTS `user_categories_with_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_categories_with_details` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`p`.`id` AS `profile_id`,`td`.`category` AS `category`,count(0) AS `favorite_count`,round(((count(0) * 100.0) / sum(count(0)) OVER (PARTITION BY `p`.`id` ) ),2) AS `percentage`,row_number() OVER (PARTITION BY `p`.`id` ORDER BY count(0) desc )  AS `category_rank` from (((`users` `u` join `profiles` `p` on((`u`.`id` = `p`.`users_id`))) join `favoritemusics` `fm` on((`p`.`id` = `fm`.`profiles_id`))) join `tracks_details` `td` on((`fm`.`audiofiles_id` = `td`.`audio_id`))) group by `u`.`id`,`u`.`name`,`p`.`id`,`td`.`category` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_albums`
--

/*!50001 DROP VIEW IF EXISTS `users_albums`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_albums` AS select `audiofiles`.`id` AS `audio_id`,`audiofiles`.`title` AS `title`,`audiofiles`.`code_name` AS `code_name`,`audiofiles`.`full_title` AS `full_title`,`audiofiles`.`img` AS `img`,`audiofiles`.`url` AS `url`,`audiofiles`.`file` AS `file`,`audiofiles`.`gif` AS `gif`,`audiofiles`.`category` AS `category`,`audiofiles`.`listens` AS `listens`,`profiles_albums`.`id` AS `albums_id`,`profiles_albums`.`name` AS `album_name`,`profiles_albums`.`logo` AS `albums_logo`,`profiles`.`id` AS `profile_id`,`profiles`.`users_id` AS `users_id`,`profiles`.`avatar` AS `avatar` from (((`audiofiles` join `profiles_albums_tracks` on((`profiles_albums_tracks`.`audiofiles_id` = `audiofiles`.`id`))) join `profiles_albums` on((`profiles_albums_tracks`.`albums_id` = `profiles_albums`.`id`))) join `profiles` on((`profiles_albums`.`profiles_id` = `profiles`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `users_full_statistics`
--

/*!50001 DROP VIEW IF EXISTS `users_full_statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `users_full_statistics` AS select `u`.`id` AS `user_id`,`u`.`name` AS `user_name`,`u`.`email` AS `email`,`p`.`id` AS `profile_id`,`p`.`avatar` AS `avatar`,`r`.`name` AS `role_name`,count(distinct `fm`.`audiofiles_id`) AS `favorite_tracks_count`,count(distinct `fa`.`authors_id`) AS `favorite_authors_count`,count(distinct `falb`.`albums_id`) AS `favorite_albums_count`,count(distinct `lpt`.`audiofiles_id`) AS `listened_tracks_count` from ((((((`users` `u` join `profiles` `p` on((`u`.`id` = `p`.`users_id`))) join `roles` `r` on((`p`.`role_id` = `r`.`id`))) left join `favoritemusics` `fm` on((`p`.`id` = `fm`.`profiles_id`))) left join `favoriteauthors` `fa` on((`p`.`id` = `fa`.`profiles_id`))) left join `favoritealbums` `falb` on((`p`.`id` = `falb`.`profiles_id`))) left join `last_usr_track` `lpt` on((`p`.`id` = `lpt`.`profiles_id`))) group by `u`.`id`,`u`.`name`,`u`.`email`,`p`.`id`,`p`.`avatar`,`r`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-06  2:16:22
