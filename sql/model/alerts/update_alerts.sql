UPDATE alerts
-- sensor_id        uuid
-- message          VARCHAR
-- type             Enum alerttype
-- title            VARCHAR
-- description      VARCHAR
SET sensor_id = COALESCE(@sensor_id, sensor_id),
    message = COALESCE(@message, message),
    type = COALESCE(@type, type),
    title = COALESCE(@title, title),
    description = COALESCE(@description, description)
-- id uuid
WHERE id = @id
RETURNING id;