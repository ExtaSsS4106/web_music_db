-- =====================================================
-- Файл: 03_functions.sql
-- Назначение: Создание пользовательских функций
-- =====================================================

USE `wm`;

DELIMITER $$

-- =====================================================
-- Функция: get_author_total_listens
-- Назначение: Возвращает общее количество прослушиваний
--             всех треков указанного автора
-- Параметры: author_id INT - идентификатор автора
-- Возвращает: BIGINT - суммарное количество прослушиваний
-- Использование: SELECT name, get_author_total_listens(id) FROM authors;
-- =====================================================
DROP FUNCTION IF EXISTS `get_author_total_listens`;
CREATE FUNCTION `get_author_total_listens`(author_id INT) RETURNS BIGINT
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
END$$

DELIMITER ;