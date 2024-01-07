UPDATE alerts
-- sensor_id uuid
-- rule_id   uuid
-- message   VARCHAR
-- type      Enum alerttype
SET sensor_id = COALESCE(@sensor_id, sensor_id),
    rule_id = COALESCE(@rule_id, rule_id),
    message = COALESCE(@message, message),
    type = COALESCE(@type, type)
-- id uuid
WHERE id = @id;