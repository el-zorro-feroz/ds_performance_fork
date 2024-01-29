INSERT INTO alerts (sensor_id, message, type, title, description)
-- 1 pos sensor_id      uuid
-- 2 pos message        VARCHAR
-- 3 pos type           Enum alerttype
-- 4 pos title          VARCHAR
-- 5 pos description    VARCHAR
VALUES (@sensor_id,@message,@type,@title,@description)
RETURNING id;