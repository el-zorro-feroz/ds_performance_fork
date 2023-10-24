UPDATE sensorhistory
-- sensor_id uuid
-- date timestamp
-- value real
SET sensor_id = ?,
	date = ?,
	value = ?
-- id uuid
WHERE id = ?;