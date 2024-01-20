INSERT INTO tabs (config_id, title)
-- 1 pos - config_id uuid
-- 2 pos - title VARCHAR
VALUES(@config_id, @title)
RETURNING *;