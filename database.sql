CREATE TABLE IF NOT EXISTS tower_hacks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    tower_id INT NOT NULL,
    hack_time DATETIME NOT NULL,
    success BOOLEAN NOT NULL
);

INSERT INTO tower_hacks (player_id, tower_id, hack_time, success) VALUES
(1, 1, NOW(), TRUE),
(2, 2, NOW(), FALSE);