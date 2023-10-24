UPDATE tabsensors
-- sensor_id uuid
-- tab_id uuid
SET sensor_id = ?,
	tab_id = ?
-- id uuid
WHERE id = ?;