UPDATE sensors
-- title VARCHAR
SET title = @title
-- id uuid
WHERE id = @id;