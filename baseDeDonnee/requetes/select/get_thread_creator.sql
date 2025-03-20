SELECT username, firstname, lastname 
FROM users JOIN threads
ON users.username = threads.creator
WHERE id_thread = ?;