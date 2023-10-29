UPDATE alerts
-- sensor_id uuid
-- rule_id   uuid
-- message   VARCHAR
-- type      Enum alerttype
SET sensor_id = @sensor_id,
    rule_id = @rule_id,
    message = @message,
    type = @type
-- id uuid
WHERE id = @id;