UPDATE configs
-- title VARCHAR
SET title = @title
-- id uuid
WHERE id = @id;