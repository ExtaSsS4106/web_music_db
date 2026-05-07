-- =====================================================
-- Файл: 05_views.sql
-- Назначение: Создание представлений (VIEW)
-- =====================================================

USE `wm`;

-- =====================================================
-- Представление 1: tracks_details
-- Назначение: Объединяет таблицы audiofiles, albums, authors
--             для удобного получения полной информации о треках
-- =====================================================
DROP VIEW IF EXISTS `tracks_details`;
CREATE VIEW `tracks_details` AS
SELECT 
    `audiofiles`.`id` AS `audio_id`,
    `audiofiles`.`title` AS `title`,
    `audiofiles`.`code_name` AS `code_name`,
    `audiofiles`.`full_title` AS `full_title`,
    `audiofiles`.`img` AS `img`,
    `audiofiles`.`url` AS `url`,
    `audiofiles`.`file` AS `file`,
    `audiofiles`.`gif` AS `gif`,
    `audiofiles`.`category` AS `category`,
    `audiofiles`.`listens` AS `listens`,
    `albums`.`id` AS `albums_id`,
    `albums`.`name` AS `album_name`,
    `albums`.`logo` AS `albums_logo`,
    `authors`.`id` AS `authors_id`,
    `authors`.`name` AS `authors_name`,
    `authors`.`logo` AS `authors_logo`
FROM `audiofiles`
JOIN `albums` ON `audiofiles`.`albums_id` = `albums`.`id`
JOIN `authors` ON `albums`.`authors_id` = `authors`.`id`;

-- =====================================================
-- Представление 2: authors_statistics
-- Назначение: Содержит аналитические данные по авторам:
--             количество альбомов, треков, суммарные прослушивания,
--             рейтинг (оконная функция DENSE_RANK)
-- =====================================================
DROP VIEW IF EXISTS `authors_statistics`;
CREATE VIEW `authors_statistics` AS
SELECT 
    `a`.`id` AS `author_id`,
    `a`.`name` AS `author_name`,
    `a`.`logo` AS `author_logo`,
    COUNT(DISTINCT `alb`.`id`) AS `albums_count`,
    COUNT(DISTINCT `af`.`id`) AS `tracks_count`,
    COALESCE(SUM(`af`.`listens`), 0) AS `total_listens`,
    `get_author_total_listens`(`a`.`id`) AS `total_listens_function`,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(`af`.`listens`), 0) DESC) AS `popularity_rank`
FROM `authors` `a`
LEFT JOIN `albums` `alb` ON `a`.`id` = `alb`.`authors_id`
LEFT JOIN `audiofiles` `af` ON `alb`.`id` = `af`.`albums_id`
GROUP BY `a`.`id`, `a`.`name`, `a`.`logo`;

-- =====================================================
-- Представление 3: users_full_statistics
-- Назначение: Агрегирует полную статистику по каждому пользователю:
--             избранные треки, авторы, альбомы, история прослушиваний
-- =====================================================
DROP VIEW IF EXISTS `users_full_statistics`;
CREATE VIEW `users_full_statistics` AS
SELECT 
    `u`.`id` AS `user_id`,
    `u`.`name` AS `user_name`,
    `u`.`email` AS `email`,
    `p`.`id` AS `profile_id`,
    `p`.`avatar` AS `avatar`,
    `r`.`name` AS `role_name`,
    COUNT(DISTINCT `fm`.`audiofiles_id`) AS `favorite_tracks_count`,
    COUNT(DISTINCT `fa`.`authors_id`) AS `favorite_authors_count`,
    COUNT(DISTINCT `falb`.`albums_id`) AS `favorite_albums_count`,
    COUNT(DISTINCT `lpt`.`audiofiles_id`) AS `listened_tracks_count`
FROM `users` `u`
JOIN `profiles` `p` ON `u`.`id` = `p`.`users_id`
JOIN `roles` `r` ON `p`.`role_id` = `r`.`id`
LEFT JOIN `favoritemusics` `fm` ON `p`.`id` = `fm`.`profiles_id`
LEFT JOIN `favoriteauthors` `fa` ON `p`.`id` = `fa`.`profiles_id`
LEFT JOIN `favoritealbums` `falb` ON `p`.`id` = `falb`.`profiles_id`
LEFT JOIN `last_usr_track` `lpt` ON `p`.`id` = `lpt`.`profiles_id`
GROUP BY `u`.`id`, `u`.`name`, `u`.`email`, `p`.`id`, `p`.`avatar`, `r`.`name`;

-- =====================================================
-- Представление 4: user_categories_with_details
-- Назначение: Анализирует предпочтения пользователей по категориям
--             с расчетом процентного соотношения и ранжированием
-- =====================================================
DROP VIEW IF EXISTS `user_categories_with_details`;
CREATE VIEW `user_categories_with_details` AS
SELECT 
    `u`.`id` AS `user_id`,
    `u`.`name` AS `user_name`,
    `p`.`id` AS `profile_id`,
    `td`.`category` AS `category`,
    COUNT(*) AS `favorite_count`,
    ROUND((COUNT(*) * 100.0) / SUM(COUNT(*)) OVER (PARTITION BY `p`.`id`), 2) AS `percentage`,
    ROW_NUMBER() OVER (PARTITION BY `p`.`id` ORDER BY COUNT(*) DESC) AS `category_rank`
FROM `users` `u`
JOIN `profiles` `p` ON `u`.`id` = `p`.`users_id`
JOIN `favoritemusics` `fm` ON `p`.`id` = `fm`.`profiles_id`
JOIN `tracks_details` `td` ON `fm`.`audiofiles_id` = `td`.`audio_id`
GROUP BY `u`.`id`, `u`.`name`, `p`.`id`, `td`.`category`;

-- =====================================================
-- Представление 5: users_albums
-- Назначение: Информация о пользовательских плейлистах и треках в них
-- =====================================================
DROP VIEW IF EXISTS `users_albums`;
CREATE VIEW `users_albums` AS
SELECT 
    `audiofiles`.`id` AS `audio_id`,
    `audiofiles`.`title` AS `title`,
    `audiofiles`.`code_name` AS `code_name`,
    `audiofiles`.`full_title` AS `full_title`,
    `audiofiles`.`img` AS `img`,
    `audiofiles`.`url` AS `url`,
    `audiofiles`.`file` AS `file`,
    `audiofiles`.`gif` AS `gif`,
    `audiofiles`.`category` AS `category`,
    `audiofiles`.`listens` AS `listens`,
    `profiles_albums`.`id` AS `albums_id`,
    `profiles_albums`.`name` AS `album_name`,
    `profiles_albums`.`logo` AS `albums_logo`,
    `profiles`.`id` AS `profile_id`,
    `profiles`.`users_id` AS `users_id`,
    `profiles`.`avatar` AS `avatar`
FROM `audiofiles`
JOIN `profiles_albums_tracks` ON `profiles_albums_tracks`.`audiofiles_id` = `audiofiles`.`id`
JOIN `profiles_albums` ON `profiles_albums_tracks`.`albums_id` = `profiles_albums`.`id`
JOIN `profiles` ON `profiles_albums`.`profiles_id` = `profiles`.`id`;