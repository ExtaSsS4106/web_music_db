-- =====================================================
-- Файл: 02_triggers.sql
-- Назначение: Создание триггеров
-- =====================================================

USE `wm`;

DELIMITER $$

-- =====================================================
-- Триггер 1: create_author
-- Назначение: При создании профиля с ролью author (role_id = 2)
--             автоматически создает запись в таблице authors
--             и связь в prof_authors
-- Срабатывает: AFTER INSERT ON profiles
-- =====================================================
DROP TRIGGER IF EXISTS `create_author`;
CREATE TRIGGER `create_author` AFTER INSERT ON `profiles` FOR EACH ROW
BEGIN
    DECLARE new_author_id INT;
    DECLARE user_name VARCHAR(255);
    
    SELECT name INTO user_name FROM users WHERE id = NEW.users_id;
    
    IF NEW.role_id = 2 THEN
        INSERT INTO authors (name) VALUES (user_name);
        SET new_author_id = LAST_INSERT_ID();
        INSERT INTO prof_authors (profiles_id, authors_id) 
        VALUES (NEW.id, new_author_id);
    END IF;
END$$

-- =====================================================
-- Триггер 2: switch_to_author
-- Назначение: При изменении роли профиля на author
--             автоматически создает автора, предотвращая дублирование
-- Срабатывает: AFTER UPDATE ON profiles
-- =====================================================
DROP TRIGGER IF EXISTS `switch_to_author`;
CREATE TRIGGER `switch_to_author` AFTER UPDATE ON `profiles` FOR EACH ROW
BEGIN
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
END$$

DELIMITER ;