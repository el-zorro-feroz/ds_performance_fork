UPDATE sensors
-- title VARCHAR
SET title = COALESCE (@title, title),
    type = COALESCE (@type, type),
	details = COALESCE (@details, details)
-- id uuid
WHERE id = @id;