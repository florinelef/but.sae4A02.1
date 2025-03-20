SELECT sender, message, time 
FROM messages
WHERE id_thread = ?
ORDER BY time ASC;