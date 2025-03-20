DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS followers;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS threads;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    username    VARCHAR(24) PRIMARY KEY,
    password    CHAR(32) NOT NULL,
    firstname   VARCHAR(50) NOT NULL,
    lastname    VARCHAR(50) NOT NULL
);

CREATE TABLE threads (
    id_thread   SERIAL PRIMARY KEY,
    creator     VARCHAR(24),
    name        VARCHAR(75),
    date        DATE,

    FOREIGN KEY (creator) REFERENCES users(username)
);

CREATE TABLE followers (
    username    VARCHAR(24),
    id_thread   INT,
    
    PRIMARY KEY (username, id_thread),
    FOREIGN KEY (username) REFERENCES users(username),
    FOREIGN KEY (id_thread) REFERENCES threads(id_thread) ON DELETE CASCADE
);

CREATE TABLE messages (
    id_message  SERIAL PRIMARY KEY,
    sender      VARCHAR(24) NOT NULL,
    id_thread   INT,
    message     VARCHAR(1024),
    time        TIMESTAMP WITH TIME ZONE,

    FOREIGN KEY (sender) REFERENCES users(username),
    FOREIGN KEY (id_thread) REFERENCES threads(id_thread) ON DELETE CASCADE
);

CREATE TABLE likes (
    username   VARCHAR(24),
    id_message INT,

    PRIMARY KEY (username, id_message),
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    FOREIGN KEY (id_message) REFERENCES messages(id_message) ON DELETE CASCADE
);