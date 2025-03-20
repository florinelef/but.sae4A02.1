\i init.sql

-- Ajout de nouveaux utilisateurs
INSERT INTO users VALUES 
    ('maxime', 'b238c13e822536cad3ac57a2280fbf45', 'Maxime', 'Gosselin'),
    ('florine', '422c3b72397f6ffbd5124e13ce919147', 'Florine', 'Lefebvre'),
    ('nath', '320c8d45fe4ee818e1d185954c2c251d', 'Nath', 'Collumeau'),
    ('baptiste', '3056849e9b6bef41c0eb17b01bfb25bb', 'Baptiste', 'Royer'),
    ('lea', 'a25cfe3d9b6a9ed52d3c7e9caa5eb4d1', 'Léa', 'Dubois'),
    ('julien', 'fd3b7526e58e83a9a02b1c5df872efea', 'Julien', 'Marchand');

-- Ajout de nouveaux threads
INSERT INTO threads (creator, name, date) VALUES
    ('maxime', 'Kakou Kakou', '2019-01-08'),
    ('florine', 'Banane Fromage Chips', '2005-06-08'),
    ('nath', 'Polybius67', '2025-02-03'),
    ('baptiste', 'Développement Web', '2023-09-15'),
    ('lea', 'Les Memes de l IUT', '2024-01-10'),
    ('julien', 'Soirée Étudiante', '2023-11-25');

-- Ajout de nouveaux followers aux threads
INSERT INTO followers VALUES
    ('maxime', 2),
    ('maxime', 3),
    ('maxime', 4),
    ('florine', 1),
    ('florine', 3),
    ('florine', 5),
    ('nath', 2),
    ('nath', 4),
    ('nath', 6),
    ('baptiste', 1),
    ('baptiste', 3),
    ('baptiste', 5),
    ('lea', 2),
    ('lea', 3),
    ('lea', 6),
    ('julien', 1),
    ('julien', 4),
    ('julien', 5);

-- Ajout de nouveaux messages dans différents fils de discussion
INSERT INTO messages (sender, id_thread, message, time) VALUES
    -- Messages dans "Kakou Kakou"
    ('maxime', 1, 'Kakou Kakou les amis, ça va?', '2020-01-08 18:00:32 +1:00'),
    ('florine', 1, 'Ca va et vous ?', '2020-01-08 18:05:32 +1:00'),
    ('baptiste', 1, 'Quelqu un sait d où vient cette expression ?', '2020-01-08 18:10:45 +1:00'),
    
    -- Messages dans "Banane Fromage Chips"
    ('florine', 2, 'Brouette Glacier Numérique', '2020-02-04 14:05:00 +1:00'),
    ('nath', 2, 'J ai testé un sandwich banane-fromage... Mauvaise idée 😅', '2020-02-05 16:12:00 +1:00'),
    
    -- Messages dans "Polybius67"
    ('nath', 3, 'Bouh', '2025-02-04 14:05:00 +1:00'),
    ('lea', 3, 'C est quoi ce thread ? Un jeu d horreur ?', '2025-02-04 15:30:00 +1:00'),

    -- Messages dans "Développement Web"
    ('baptiste', 4, 'Qui a déjà utilisé Tailwind CSS ?', '2023-09-16 10:20:00 +1:00'),
    ('maxime', 4, 'C est super pratique ! Moins de CSS à écrire.', '2023-09-16 10:35:00 +1:00'),

    -- Messages dans "Les Memes de l'IUT"
    ('lea', 5, 'J ai trouvé un meme parfait pour la semaine d examens 😂', '2024-01-10 21:45:00 +1:00'),
    ('julien', 5, 'Balance !', '2024-01-10 21:50:00 +1:00'),

    -- Messages dans "Soirée Étudiante"
    ('julien', 6, 'Qui vient à la soirée vendredi soir ?', '2023-11-26 18:00:00 +1:00'),
    ('florine', 6, 'Moi ! Ça commence à quelle heure ?', '2023-11-26 18:10:00 +1:00'),
    ('baptiste', 6, 'Je ramène des pizzas 🍕', '2023-11-26 18:15:00 +1:00');

-- Ajout de likes aux messages
INSERT INTO likes VALUES
    -- Likes sur "Kakou Kakou"
    ('florine', 1),
    ('baptiste', 1),
    ('lea', 1),
    ('julien', 2),

    -- Likes sur "Banane Fromage Chips"
    ('nath', 4),
    ('baptiste', 4),
    ('maxime', 5),

    -- Likes sur "Polybius67"
    ('julien', 6),
    ('florine', 6),
    ('maxime', 7),

    -- Likes sur "Développement Web"
    ('nath', 8),
    ('julien', 8),
    ('florine', 9),

    -- Likes sur "Les Memes de l'IUT"
    ('maxime', 10),
    ('nath', 10),
    ('baptiste', 11),

    -- Likes sur "Soirée Étudiante"
    ('lea', 12),
    ('baptiste', 12),
    ('maxime', 13),
    ('florine', 14);
