INSERT INTO sensors (config_id, title, type, details)
-- 1 pos - config_id uuid
-- 2 pos - title VARCHAR
-- 3 pos - type Enum sensortype
VALUES(@config_id, @title, @type, @details)
RETURNING id;