UPDATE sensors
-- title VARCHAR
SET title = COALESCE (@title, title),
    type = COALESCE (@type, type)
-- id uuid
WHERE id = @id;