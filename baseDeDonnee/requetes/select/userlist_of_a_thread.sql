SELECT username, firstname, lastname 
FROM users JOIN followers USING (username)
WHERE id_thread = ?;