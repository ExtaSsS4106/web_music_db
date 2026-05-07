-- =====================================================
-- Файл: 01_schema.sql
-- Назначение: Создание всех таблиц базы данных wm
-- =====================================================

-- Создание базы данных
CREATE DATABASE IF NOT EXISTS `wm` DEFAULT CHARACTER SET utf8mb3;
USE `wm`;

-- Таблица: roles (роли пользователей)
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: users (пользователи)
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: authors (авторы)
DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: albums (альбомы)
DROP TABLE IF EXISTS `albums`;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `authors_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albums_authors1_idx` (`authors_id`),
  CONSTRAINT `fk_albums_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: audiofiles (аудиотреки)
DROP TABLE IF EXISTS `audiofiles`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: profiles (профили пользователей)
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profiles_users` (`users_id`),
  KEY `fk_profiles_roles_idx` (`role_id`),
  CONSTRAINT `fk_profiles_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_profiles_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: prof_authors (связь профилей с авторами)
DROP TABLE IF EXISTS `prof_authors`;
CREATE TABLE `prof_authors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profiles_id` int NOT NULL,
  `authors_id` int NOT NULL,
  PRIMARY KEY (`id`,`profiles_id`,`authors_id`),
  KEY `fk_prof_authors_profiles1_idx` (`profiles_id`),
  KEY `fk_prof_authors_authors1_idx` (`authors_id`),
  CONSTRAINT `fk_prof_authors_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`),
  CONSTRAINT `fk_prof_authors_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: favoritemusics (избранные треки)
DROP TABLE IF EXISTS `favoritemusics`;
CREATE TABLE `favoritemusics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoritemusics_audiofiles1_idx` (`audiofiles_id`),
  KEY `fk_favoritemusics_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoritemusics_audiofiles1` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`),
  CONSTRAINT `fk_favoritemusics_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: favoriteauthors (избранные авторы)
DROP TABLE IF EXISTS `favoriteauthors`;
CREATE TABLE `favoriteauthors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `authors_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoriteauthors_authors1_idx` (`authors_id`),
  KEY `fk_favoriteauthors_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoriteauthors_authors1` FOREIGN KEY (`authors_id`) REFERENCES `authors` (`id`),
  CONSTRAINT `fk_favoriteauthors_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: favoritealbums (избранные альбомы)
DROP TABLE IF EXISTS `favoritealbums`;
CREATE TABLE `favoritealbums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `albums_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_favoritealbums_albums1_idx` (`albums_id`),
  KEY `fk_favoritealbums_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_favoritealbums_albums1` FOREIGN KEY (`albums_id`) REFERENCES `albums` (`id`),
  CONSTRAINT `fk_favoritealbums_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: last_usr_track (история прослушиваний)
DROP TABLE IF EXISTS `last_usr_track`;
CREATE TABLE `last_usr_track` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_last_usr_track_audiofiles1_idx` (`audiofiles_id`),
  KEY `fk_last_usr_track_profiles1_idx` (`profiles_id`),
  CONSTRAINT `fk_last_usr_track_audiofiles1` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`),
  CONSTRAINT `fk_last_usr_track_profiles1` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: profiles_albums (плейлисты пользователей)
DROP TABLE IF EXISTS `profiles_albums`;
CREATE TABLE `profiles_albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(45) DEFAULT NULL,
  `profiles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profiles_albums_idx` (`profiles_id`),
  CONSTRAINT `fk_profiles_albums` FOREIGN KEY (`profiles_id`) REFERENCES `profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Таблица: profiles_albums_tracks (треки в плейлистах)
DROP TABLE IF EXISTS `profiles_albums_tracks`;
CREATE TABLE `profiles_albums_tracks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audiofiles_id` int NOT NULL,
  `albums_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_albums_idx` (`albums_id`),
  KEY `fk_audios_idx` (`audiofiles_id`),
  CONSTRAINT `fk_albums` FOREIGN KEY (`albums_id`) REFERENCES `profiles_albums` (`id`),
  CONSTRAINT `fk_audios` FOREIGN KEY (`audiofiles_id`) REFERENCES `audiofiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;