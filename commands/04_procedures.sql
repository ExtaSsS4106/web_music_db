-- =====================================================
-- Файл: 04_procedures.sql
-- Назначение: Создание хранимых процедур
-- =====================================================

USE `wm`;

DELIMITER $$

-- =====================================================
-- Процедура 1: create_user
-- Назначение: Создание нового пользователя и его профиля
-- Параметры:
--   p_name - имя пользователя
--   p_email - email пользователя
--   p_password - пароль (рекомендуется передавать MD5)
--   p_role - ID роли (1-пользователь, 2-автор, 3-админ)
-- Обработчики: проверка уникальности имени и email
-- =====================================================
DROP PROCEDURE IF EXISTS `create_user`;
CREATE PROCEDURE `create_user`(
    IN p_name VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_role INT
)
BEGIN
    DECLARE name_count INT;
    DECLARE email_count INT;
    DECLARE new_user_id INT;

    -- Проверка на пустые поля
    IF p_name IS NULL OR p_name = '' OR 
       p_email IS NULL OR p_email = '' OR 
       p_password IS NULL OR p_password = '' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Ошибка: необходимо заполнить все поля';
    END IF;
    
    -- Проверка уникальности имени
    SELECT COUNT(*) INTO name_count FROM users WHERE name = p_name;
    
    -- Проверка уникальности email
    SELECT COUNT(*) INTO email_count FROM users WHERE email = p_email;
    
    IF name_count > 0 THEN
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'пользователь с таким именем уже есть';
    
    ELSEIF email_count > 0 THEN
        SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'пользователь с такой почтой уже есть';
    
    ELSE 
        INSERT INTO users (name, email, password) VALUES (p_name, p_email, p_password);
        SET new_user_id = LAST_INSERT_ID();
        INSERT INTO profiles (users_id, role_id) VALUES (new_user_id, p_role);
    END IF;
END$$

-- =====================================================
-- Процедура 2: add_new_track
-- Назначение: Добавление нового трека
-- Параметры:
--   p_title - название трека
--   p_code_name - уникальный код (если пусто - генерируется)
--   p_file - путь к файлу
--   p_album_id - ID альбома
--   p_full_title - полное название (опционально)
--   p_img - путь к изображению (опционально)
--   p_url - URL (опционально)
--   p_gif - путь к GIF (опционально)
--   p_category - категория/жанр (опционально)
-- Транзакция: START TRANSACTION / COMMIT / ROLLBACK
-- Обработчики: DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
-- =====================================================
DROP PROCEDURE IF EXISTS `add_new_track`;
CREATE PROCEDURE `add_new_track`(
    IN p_title VARCHAR(255),
    IN p_code_name VARCHAR(255),
    IN p_file VARCHAR(255),
    IN p_album_id INT,
    IN p_full_title VARCHAR(255),
    IN p_img VARCHAR(255),
    IN p_url VARCHAR(45),
    IN p_gif VARCHAR(255),
    IN p_category VARCHAR(45)
)
BEGIN
    DECLARE v_code_name VARCHAR(255);
    
    -- Обработчик исключений SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Обработчик предупреждений
    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;
    
    -- Проверка обязательных полей
    IF p_title IS NULL OR p_title = '' OR
       p_file IS NULL OR p_file = '' OR
       p_album_id IS NULL OR p_album_id = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Required fields: title, file, album_id cannot be empty or null';
    END IF;
    
    -- Генерация code_name если не указан
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
    
    -- Транзакция
    START TRANSACTION;
    
    INSERT INTO `audiofiles` (title, code_name, `file`, albums_id, full_title, img, url, gif, category) 
    VALUES (p_title, v_code_name, p_file, p_album_id, p_full_title, p_img, p_url, p_gif, p_category);
    
    COMMIT;
END$$

-- =====================================================
-- Процедура 3: add_to_favorites
-- Назначение: Добавление трека в избранное пользователя
-- Параметры:
--   p_audiofile_id - ID трека
--   p_profile_id - ID профиля пользователя
-- Логика: Проверяет, не добавлен ли уже трек
-- =====================================================
DROP PROCEDURE IF EXISTS `add_to_favorites`;
CREATE PROCEDURE `add_to_favorites`(
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
END$$

-- =====================================================
-- Процедура 4: remove_from_favorites
-- Назначение: Удаление трека из избранного пользователя
-- Параметры:
--   p_audiofile_id - ID трека
--   p_profile_id - ID профиля пользователя
-- =====================================================
DROP PROCEDURE IF EXISTS `remove_from_favorites`;
CREATE PROCEDURE `remove_from_favorites`(
    IN p_audiofile_id INT,
    IN p_profile_id INT
)
BEGIN
    DELETE FROM favoritemusics 
    WHERE audiofiles_id = p_audiofile_id AND profiles_id = p_profile_id;
    
    SELECT CONCAT('Трек ', p_audiofile_id, ' удален из избранного') AS message;
END$$

DELIMITER ;