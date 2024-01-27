UPDATE sensorrules
SET type = COALESCE(@type, type),
    value = COALESCE(@value, value)
-- id uuid
WHERE id = @id;