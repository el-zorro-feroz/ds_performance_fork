INSERT INTO alerts (sensor_id, rule_id, message, type, title, description)
-- 1 pos sensor_id      uuid
-- 2 pos rule_id        uuid
-- 3 pos message        VARCHAR
-- 4 pos type           Enum alerttype
-- 5 pos title          VARCHAR
-- 6 pos description    VARCHAR
VALUES (@sensor_id,@rule_id,@message,@type,@title,@description);