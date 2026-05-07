-- =====================================================
-- Файл: 07_data.sql
-- Назначение: Заполнение базы данных тестовыми данными
-- =====================================================

USE `wm`;

-- 1. Заполнение ролей
INSERT INTO `roles` (`name`) VALUES
('user'),
('author'),
('admin');

-- 2. Заполнение пользователей
INSERT INTO `users` (`name`, `email`, `password`) VALUES
('ivan_petrov', 'ivan@example.com', MD5('password123')),
('maria_sidorova', 'maria@example.com', MD5('password123')),
('alexey_smirnov', 'alexey@example.com', MD5('password123')),
('elena_kozlova', 'elena@example.com', MD5('password123')),
('dmitry_volkov', 'dmitry@example.com', MD5('password123'));

-- 3. Заполнение профилей (триггер create_author создаст авторов)
INSERT INTO `profiles` (`users_id`, `avatar`, `role_id`) VALUES
(1, 'avatars/ivan.jpg', 1),
(2, 'avatars/maria.jpg', 2),
(3, 'avatars/alexey.jpg', 2),
(4, 'avatars/elena.jpg', 1),
(5, 'avatars/dmitry.jpg', 3);

-- 4. Заполнение альбомов
INSERT INTO `albums` (`name`, `logo`, `authors_id`) VALUES
('Summer Hits 2024', 'albums/summer2024.jpg', 1),
('Rock Ballads', 'albums/rock_ballads.jpg', 2),
('Electronic Dreams', 'albums/electronic.jpg', 1),
('Acoustic Morning', 'albums/acoustic.jpg', 2);

-- 5. Заполнение аудиофайлов
INSERT INTO `audiofiles` (`title`, `code_name`, `full_title`, `img`, `url`, `file`, `gif`, `category`, `albums_id`, `listens`) VALUES
('Sunshine', 'sunshine_2024', 'Sunshine - Summer Hit', 'tracks/sunshine.jpg', '/track/1', '/files/sunshine.mp3', NULL, 'pop', 1, 15420),
('Beach Party', 'beach_party', 'Beach Party - Summer Mix', 'tracks/beach.jpg', '/track/2', '/files/beach_party.mp3', NULL, 'dance', 1, 12350),
('Cool Breeze', 'cool_breeze', 'Cool Breeze - Chill Version', 'tracks/breeze.jpg', '/track/3', '/files/cool_breeze.mp3', NULL, 'chill', 1, 8900),
('Lost in Love', 'lost_in_love', 'Lost in Love - Rock Ballad', 'tracks/lost_love.jpg', '/track/4', '/files/lost_in_love.mp3', NULL, 'rock', 2, 22100),
('Midnight Rain', 'midnight_rain', 'Midnight Rain - Acoustic Rock', 'tracks/midnight.jpg', '/track/5', '/files/midnight_rain.mp3', 'tracks/midnight.gif', 'rock', 2, 18760),
('Broken Dreams', 'broken_dreams', 'Broken Dreams - Emotional Rock', 'tracks/broken.jpg', '/track/6', '/files/broken_dreams.mp3', NULL, 'rock', 2, 15630),
('Neon Lights', 'neon_lights', 'Neon Lights - Electronic', 'tracks/neon.jpg', '/track/7', '/files/neon_lights.mp3', 'tracks/neon.gif', 'electronic', 3, 34200),
('Cyber Pulse', 'cyber_pulse', 'Cyber Pulse - Tech House', 'tracks/cyber.jpg', '/track/8', '/files/cyber_pulse.mp3', NULL, 'electronic', 3, 28900),
('Future Bass', 'future_bass', 'Future Bass - EDM', 'tracks/future.jpg', '/track/9', '/files/future_bass.mp3', NULL, 'electronic', 3, 21450),
('Sunrise Melody', 'sunrise_melody', 'Sunrise Melody - Acoustic', 'tracks/sunrise.jpg', '/track/10', '/files/sunrise_melody.mp3', NULL, 'acoustic', 4, 12340),
('Coffee and Guitar', 'coffee_guitar', 'Coffee and Guitar - Morning Mix', 'tracks/coffee.jpg', '/track/11', '/files/coffee_guitar.mp3', 'tracks/coffee.gif', 'acoustic', 4, 9870),
('Gentle Rain', 'gentle_rain', 'Gentle Rain - Piano', 'tracks/rain.jpg', '/track/12', '/files/gentle_rain.mp3', NULL, 'piano', 4, 7650);

-- 6. Избранные треки
INSERT INTO `favoritemusics` (`audiofiles_id`, `profiles_id`) VALUES
(1, 1), (4, 1), (7, 1), (2, 2), (5, 2), (8, 3), (1, 4), (10, 4), (4, 4), (7, 5);

-- 7. Избранные альбомы
INSERT INTO `favoritealbums` (`albums_id`, `profiles_id`) VALUES
(1, 1), (3, 1), (2, 2), (4, 3), (1, 4), (3, 5);

-- 8. Избранные авторы
INSERT INTO `favoriteauthors` (`authors_id`, `profiles_id`) VALUES
(1, 1), (2, 2), (1, 3), (2, 4), (1, 5);

-- 9. История прослушиваний
INSERT INTO `last_usr_track` (`audiofiles_id`, `profiles_id`) VALUES
(1, 1), (4, 1), (7, 2), (5, 2), (8, 3), (2, 3), (10, 4), (11, 4), (7, 5), (12, 5);

-- 10. Пользовательские плейлисты
INSERT INTO `profiles_albums` (`name`, `logo`, `profiles_id`) VALUES
('My Favorite Rock', 'playlists/rock_playlist.jpg', 1),
('Chill Morning', 'playlists/chill.jpg', 4),
('Workout Mix', 'playlists/workout.jpg', 5);

-- 11. Треки в плейлистах
INSERT INTO `profiles_albums_tracks` (`audiofiles_id`, `albums_id`) VALUES
(4, 1), (5, 1), (6, 1), (10, 2), (11, 2), (12, 2), (3, 2), (1, 3), (2, 3), (7, 3), (8, 3);