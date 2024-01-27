UPDATE sensorhistory
-- sensor_id uuid
-- date timestamp
-- value real
SET sensor_id = COALESCE (@sensor_id, sensor_id),
	date = COALESCE (@date, date),
	value = COALESCE (@value, value)
-- id uuid
WHERE id = @id;