UPDATE Rules
 -- description VARCHAR
SET description = COALESCE(@description, description),
-- id uuid
WHERE id = @id;