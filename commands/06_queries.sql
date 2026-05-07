-- =====================================================
-- Файл: 06_queries.sql
-- Назначение: Типовые запросы для бизнес-процессов
-- =====================================================

USE `wm`;

-- =====================================================
-- Запрос 1: Топ-10 самых популярных треков
-- =====================================================
SELECT 
    td.audio_id,
    td.title AS track_name,
    td.authors_name AS author,
    td.album_name AS album,
    td.listens AS listen_count
FROM tracks_details td
ORDER BY td.listens DESC
LIMIT 10;

-- =====================================================
-- Запрос 2: Полная статистика по пользователю (ID=1)
-- =====================================================
SELECT 
    u.name AS username,
    u.email,
    COUNT(DISTINCT fm.audiofiles_id) AS favorite_tracks,
    COUNT(DISTINCT fa.authors_id) AS favorite_authors,
    COUNT(DISTINCT falb.albums_id) AS favorite_albums,
    COUNT(DISTINCT lpt.audiofiles_id) AS listened_tracks
FROM users u
JOIN profiles p ON u.id = p.users_id
LEFT JOIN favoritemusics fm ON p.id = fm.profiles_id
LEFT JOIN favoriteauthors fa ON p.id = fa.profiles_id
LEFT JOIN favoritealbums falb ON p.id = falb.profiles_id
LEFT JOIN last_usr_track lpt ON p.id = lpt.profiles_id
WHERE u.id = 1
GROUP BY u.id, u.name, u.email;

-- =====================================================
-- Запрос 3: Рекомендации на основе любимых категорий (CTE)
-- =====================================================
WITH user_categories AS (
    SELECT DISTINCT td.category
    FROM favoritemusics fm
    JOIN tracks_details td ON fm.audiofiles_id = td.audio_id
    WHERE fm.profiles_id = 1
)
SELECT 
    td.title AS recommended_track,
    td.authors_name AS author,
    td.category AS genre,
    td.listens AS popularity
FROM tracks_details td
WHERE td.category IN (SELECT category FROM user_categories)
  AND td.audio_id NOT IN (
      SELECT audiofiles_id 
      FROM favoritemusics 
      WHERE profiles_id = 1
  )
ORDER BY td.listens DESC
LIMIT 10;

-- =====================================================
-- Запрос 4: Рейтинг авторов (с оконной функцией)
-- =====================================================
SELECT 
    a.name AS author_name,
    COUNT(DISTINCT alb.id) AS albums_count,
    COUNT(DISTINCT af.id) AS tracks_count,
    COALESCE(SUM(af.listens), 0) AS total_listens,
    get_author_total_listens(a.id) AS total_listens_function,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(af.listens), 0) DESC) AS popularity_rank
FROM authors a
LEFT JOIN albums alb ON a.id = alb.authors_id
LEFT JOIN audiofiles af ON alb.id = af.albums_id
GROUP BY a.id, a.name
ORDER BY total_listens DESC;

-- =====================================================
-- Запрос 5: Недавно прослушанные треки (история)
-- =====================================================
SELECT 
    lpt.id AS listen_id,
    td.title AS track_name,
    td.authors_name AS author,
    td.album_name AS album
FROM last_usr_track lpt
JOIN tracks_details td ON lpt.audiofiles_id = td.audio_id
WHERE lpt.profiles_id = 1
ORDER BY lpt.id DESC
LIMIT 20;