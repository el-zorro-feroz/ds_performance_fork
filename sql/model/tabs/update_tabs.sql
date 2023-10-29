UPDATE tabs
-- 1 pos - config_id uuid
-- 2 pos - title VARCHAR
SET config_id = @config_id,
	title = @title
-- id uuid
WHERE id = @id;