CREATE DATABASE music_library_db;

USE music_library_db;


USE music_library_db;

-- 1. ARTISTS
CREATE TABLE Artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(150) NOT NULL UNIQUE,
    country VARCHAR(100),
    formed_year YEAR
);

-- 2. GENRES
CREATE TABLE Genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(100) NOT NULL UNIQUE
);

-- 3. ALBUMS
CREATE TABLE Albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_title VARCHAR(200) NOT NULL,
    artist_id INT NOT NULL,
    release_date DATE,
    record_label VARCHAR(150),
    FOREIGN KEY (artist_id)
        REFERENCES Artists(artist_id)
);

-- 4. TRACKS
CREATE TABLE Tracks (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    track_title VARCHAR(200) NOT NULL,
    album_id INT,
    artist_id INT NOT NULL,
    genre_id INT NOT NULL,
    duration_seconds INT,
    release_date DATE,
    FOREIGN KEY (album_id)
        REFERENCES Albums(album_id),
    FOREIGN KEY (artist_id)
        REFERENCES Artists(artist_id),
    FOREIGN KEY (genre_id)
        REFERENCES Genres(genre_id)
);

-- 5. USERS
CREATE TABLE Library_Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(150) UNIQUE
);

-- 6. PLAYLISTS
CREATE TABLE Playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    playlist_name VARCHAR(150) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES Library_Users(user_id)
);

-- 7. PLAYLIST TRACKS
CREATE TABLE Playlist_Tracks (
    playlist_id INT NOT NULL,
    position INT NOT NULL,
    track_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, position),
    UNIQUE (playlist_id, track_id),
    FOREIGN KEY (playlist_id)
        REFERENCES Playlists(playlist_id),
    FOREIGN KEY (track_id)
        REFERENCES Tracks(track_id)
);

-- 8. LISTENING HISTORY
CREATE TABLE Listening_History (
    history_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    track_id INT NOT NULL,
    played_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES Library_Users(user_id),
    FOREIGN KEY (track_id)
        REFERENCES Tracks(track_id)
);

-- VERIFY
SHOW TABLES;

USE music_library_db;

-- 1. Add artists
INSERT INTO Artists (artist_name, country, formed_year) VALUES
('The Weeknd', 'Canada', 2009),
('Taylor Swift', 'USA', 2004),
('Arijit Singh', 'India', 2005),
('Coldplay', 'UK', 1997),
('Ed Sheeran', 'UK', 2004);

-- 2. Add genres
INSERT INTO Genres (genre_name) VALUES
('Pop'),
('R&B'),
('Bollywood'),
('Rock'),
('Indie');

-- 3. Add albums
INSERT INTO Albums (album_title, artist_id, release_date, record_label) VALUES
('After Hours', 1, '2020-03-20', 'XO Records'),
('1989', 2, '2014-10-27', 'Big Machine Records'),
('Aashiqui 2', 3, '2013-04-26', 'T-Series'),
('Parachutes', 4, '2000-07-10', 'Parlophone'),
('Divide', 5, '2017-03-03', 'Asylum Records');

-- 4. Add tracks
INSERT INTO Tracks
(track_title, album_id, artist_id, genre_id, duration_seconds, release_date)
VALUES
('Blinding Lights', 1, 1, 2, 200, '2019-11-29'),
('Save Your Tears', 1, 1, 2, 215, '2020-03-20'),
('Blank Space', 2, 2, 1, 231, '2014-11-10'),
('Style', 2, 2, 1, 231, '2014-10-27'),
('Tum Hi Ho', 3, 3, 3, 262, '2013-04-16'),
('Chahun Main Ya Naa', 3, 3, 3, 300, '2013-04-26'),
('Yellow', 4, 4, 4, 266, '2000-06-26'),
('Shiver', 4, 4, 4, 299, '2000-07-10'),
('Shape of You', 5, 5, 1, 233, '2017-01-06'),
('Perfect', 5, 5, 1, 263, '2017-03-03');

-- 5. Add users
INSERT INTO Library_Users (username, email) VALUES
('musiclover', 'musiclover@example.com'),
('playlistfan', 'playlistfan@example.com');

-- 6. Verify inserted data
SELECT * FROM Artists;
SELECT * FROM Genres;
SELECT * FROM Albums;
SELECT * FROM Tracks;
SELECT * FROM Library_Users;

USE music_library_db;

-- 1. Create playlists
INSERT INTO Playlists (user_id, playlist_name) VALUES
(1, 'My Daily Mix'),
(1, 'Late Night Vibes'),
(2, 'Favourite Songs');

-- 2. Add tracks to playlists
INSERT INTO Playlist_Tracks
(playlist_id, position, track_id)
VALUES
(1, 1, 1),
(1, 2, 3),
(1, 3, 5),
(1, 4, 9),
(2, 1, 2),
(2, 2, 7),
(2, 3, 10),
(3, 1, 4),
(3, 2, 6),
(3, 3, 8);

-- 3. Add listening history
INSERT INTO Listening_History (user_id, track_id, played_at) VALUES
(1, 1, '2026-11-01 09:00:00'),
(1, 3, '2026-11-01 09:05:00'),
(1, 1, '2026-11-01 09:10:00'),
(1, 5, '2026-11-01 09:15:00'),
(1, 9, '2026-11-02 10:00:00'),
(1, 1, '2026-11-02 10:05:00'),
(1, 7, '2026-11-02 10:10:00'),
(1, 3, '2026-11-03 11:00:00'),
(1, 5, '2026-11-03 11:05:00'),
(2, 2, '2026-11-01 18:00:00'),
(2, 4, '2026-11-01 18:05:00'),
(2, 2, '2026-11-02 19:00:00'),
(2, 6, '2026-11-02 19:05:00'),
(2, 8, '2026-11-03 20:00:00'),
(2, 10, '2026-11-03 20:05:00'),
(2, 1, '2026-11-03 20:10:00');

-- 4. Verify playlists
SELECT * FROM Playlists;

-- 5. Verify playlist tracks
SELECT * FROM Playlist_Tracks;


USE music_library_db;

INSERT INTO Artists (artist_name, country, formed_year)
VALUES ('Imagine Dragons', 'USA', 2008);

INSERT INTO Albums (album_title, artist_id, release_date, record_label)
VALUES ('Evolve', 6, '2017-06-23', 'Interscope Records');

INSERT INTO Tracks
(track_title, album_id, artist_id, genre_id, duration_seconds, release_date)
VALUES
('Believer', 6, 6, 4, 204, '2017-02-01');

SELECT * FROM Artists;

SELECT * FROM Tracks;

SELECT
    t.track_title,
    a.artist_name,
    al.album_title,
    g.genre_name
FROM Tracks t
JOIN Artists a ON t.artist_id = a.artist_id
LEFT JOIN Albums al ON t.album_id = al.album_id
JOIN Genres g ON t.genre_id = g.genre_id;

UPDATE Artists
SET country = 'United States'
WHERE artist_name = 'Imagine Dragons';

UPDATE Tracks
SET duration_seconds = 210
WHERE track_title = 'Believer';

SELECT track_id, track_title
FROM Tracks
WHERE track_title = 'Believer';

UPDATE Tracks
SET duration_seconds = 210
WHERE track_id = 11;

SELECT *
FROM Tracks
WHERE track_id = 11;

DELETE FROM Tracks
WHERE track_id = 12;

SELECT *
FROM Tracks
WHERE track_title = 'Temporary Track';

SELECT *
FROM Tracks
WHERE track_title LIKE '%Lights%';

SELECT
    t.track_title,
    a.artist_name
FROM Tracks t
JOIN Artists a
ON t.artist_id = a.artist_id
WHERE a.artist_name LIKE '%Weeknd%';

SELECT
    t.track_title,
    a.artist_name,
    g.genre_name
FROM Tracks t
JOIN Artists a ON t.artist_id = a.artist_id
JOIN Genres g ON t.genre_id = g.genre_id
WHERE g.genre_name = 'Pop';

SELECT
    p.playlist_id,
    p.playlist_name,
    u.username,
    p.created_at
FROM Playlists p
JOIN Library_Users u
ON p.user_id = u.user_id;

SELECT
    p.playlist_name,
    pt.position,
    t.track_title,
    a.artist_name
FROM Playlist_Tracks pt
JOIN Playlists p ON pt.playlist_id = p.playlist_id
JOIN Tracks t ON pt.track_id = t.track_id
JOIN Artists a ON t.artist_id = a.artist_id
WHERE p.playlist_id = 1
ORDER BY pt.position;

INSERT INTO Playlist_Tracks
(playlist_id, position, track_id)
VALUES
(1, 5, 11);

DELETE FROM Playlist_Tracks
WHERE playlist_id = 1
AND position = 5;

SELECT
    t.track_title,
    a.artist_name,
    COUNT(lh.history_id) AS total_plays
FROM Listening_History lh
JOIN Tracks t ON lh.track_id = t.track_id
JOIN Artists a ON t.artist_id = a.artist_id
GROUP BY t.track_id, t.track_title, a.artist_name
ORDER BY total_plays DESC;

SELECT
    g.genre_name,
    COUNT(lh.history_id) AS total_plays
FROM Listening_History lh
JOIN Tracks t ON lh.track_id = t.track_id
JOIN Genres g ON t.genre_id = g.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY total_plays DESC;

USE music_library_db;

ALTER TABLE Tracks
ADD FULLTEXT INDEX ft_track_title (track_title);

SHOW INDEX FROM Tracks;

SHOW INDEX FROM Artists;

SHOW INDEX FROM Playlist_Tracks;

USE music_library_db;

EXPLAIN
SELECT *
FROM Tracks
WHERE track_title LIKE '%Lights%';

EXPLAIN
SELECT *
FROM Tracks
WHERE track_title LIKE 'Blinding%';

EXPLAIN
SELECT *
FROM Tracks
WHERE MATCH(track_title)
AGAINST('Blinding' IN NATURAL LANGUAGE MODE);


USE music_library_db;

CREATE OR REPLACE VIEW Track_Details AS
SELECT
    t.track_id,
    t.track_title,
    a.artist_name,
    al.album_title,
    g.genre_name,
    t.duration_seconds,
    t.release_date
FROM Tracks t
JOIN Artists a
    ON t.artist_id = a.artist_id
LEFT JOIN Albums al
    ON t.album_id = al.album_id
JOIN Genres g
    ON t.genre_id = g.genre_id;
    
    SELECT * FROM Track_Details;
    
    SELECT *
FROM Track_Details
WHERE track_title LIKE '%Lights%';


CREATE OR REPLACE VIEW Top_Artists AS
SELECT
    a.artist_id,
    a.artist_name,
    COUNT(lh.history_id) AS total_plays
FROM Artists a
LEFT JOIN Tracks t
    ON a.artist_id = t.artist_id
LEFT JOIN Listening_History lh
    ON t.track_id = lh.track_id
GROUP BY
    a.artist_id,
    a.artist_name;
    
    
    SELECT *
FROM Top_Artists
ORDER BY total_plays DESC;


WITH TrackPlays AS (
    SELECT
        g.genre_name,
        t.track_id,
        t.track_title,
        COUNT(lh.history_id) AS total_plays
    FROM Tracks t
    JOIN Genres g
        ON t.genre_id = g.genre_id
    LEFT JOIN Listening_History lh
        ON t.track_id = lh.track_id
    GROUP BY
        g.genre_name,
        t.track_id,
        t.track_title
),
RankedTracks AS (
    SELECT
        genre_name,
        track_title,
        total_plays,
        DENSE_RANK() OVER (
            PARTITION BY genre_name
            ORDER BY total_plays DESC
        ) AS track_rank
    FROM TrackPlays
)
SELECT *
FROM RankedTracks
WHERE track_rank <= 5
ORDER BY genre_name, track_rank;



USE music_library_db;

SELECT VERSION();


USE music_library_db;

WITH RankedTracks AS (
    SELECT
        g.genre_name,
        t.track_title,
        COUNT(lh.history_id) AS total_plays,
        DENSE_RANK() OVER (
            PARTITION BY g.genre_name
            ORDER BY COUNT(lh.history_id) DESC
        ) AS track_rank
    FROM Tracks t
    JOIN Genres g
        ON t.genre_id = g.genre_id
    LEFT JOIN Listening_History lh
        ON t.track_id = lh.track_id
    GROUP BY
        g.genre_name,
        t.track_id,
        t.track_title
)


SELECT
    lh.user_id,
    lh.played_at,
    t.track_title AS current_track,
    LEAD(t.track_title) OVER (
        PARTITION BY lh.user_id
        ORDER BY lh.played_at, lh.history_id
    ) AS next_track
FROM Listening_History lh
JOIN Tracks t
    ON lh.track_id = t.track_id
ORDER BY lh.user_id, lh.played_at, lh.history_id;
SELECT *
FROM RankedTracks
WHERE track_rank <= 5
ORDER BY genre_name, track_rank;

SELECT
    lh.user_id,
    t.track_title AS current_track,
    LEAD(t.track_title) OVER (
        PARTITION BY lh.user_id
        ORDER BY lh.played_at, lh.history_id
    ) AS next_track
FROM Listening_History lh
JOIN Tracks t ON lh.track_id = t.track_id
ORDER BY lh.user_id, lh.played_at, lh.history_id;

USE music_library_db;

WITH DailyPlays AS (
    SELECT
        DATE(played_at) AS play_date,
        COUNT(*) AS daily_plays
    FROM Listening_History
    GROUP BY DATE(played_at)
)
SELECT
    play_date,
    daily_plays,
    SUM(daily_plays) OVER (
        ORDER BY play_date
    ) AS running_total
FROM DailyPlays
ORDER BY play_date;

USE music_library_db;

WITH TrackPlayCounts AS (
    SELECT
        al.album_id,
        al.album_title,
        t.track_id,
        t.track_title,
        COUNT(lh.history_id) AS track_plays
    FROM Albums al
    JOIN Tracks t
        ON al.album_id = t.album_id
    LEFT JOIN Listening_History lh
        ON t.track_id = lh.track_id
    GROUP BY
        al.album_id,
        al.album_title,
        t.track_id,
        t.track_title
)
SELECT
    album_title,
    track_title,
    track_plays,
    SUM(track_plays) OVER (
        PARTITION BY album_id
    ) AS album_total_plays,
    ROUND(
        track_plays * 100.0 /
        NULLIF(SUM(track_plays) OVER (
            PARTITION BY album_id
        ), 0),
        2
    ) AS contribution_percentage
FROM TrackPlayCounts
ORDER BY album_title, contribution_percentage DESC;


USE music_library_db;

-- 1. Check all tables and views
SHOW FULL TABLES;

-- 2. Check record counts
SELECT 'Artists' AS table_name, COUNT(*) AS total FROM Artists
UNION ALL
SELECT 'Genres', COUNT(*) FROM Genres
UNION ALL
SELECT 'Albums', COUNT(*) FROM Albums
UNION ALL
SELECT 'Tracks', COUNT(*) FROM Tracks
UNION ALL
SELECT 'Library_Users', COUNT(*) FROM Library_Users
UNION ALL
SELECT 'Playlists', COUNT(*) FROM Playlists
UNION ALL
SELECT 'Playlist_Tracks', COUNT(*) FROM Playlist_Tracks
UNION ALL
SELECT 'Listening_History', COUNT(*) FROM Listening_History;

-- 3. Check both views
SELECT * FROM Track_Details;
SELECT * FROM Top_Artists;


