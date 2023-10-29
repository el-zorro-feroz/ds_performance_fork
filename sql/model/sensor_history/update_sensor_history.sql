UPDATE sensorhistory
-- sensor_id uuid
-- date timestamp
-- value real
SET sensor_id = @sensor_id,
	date = @date,
	value = @value
-- id uuid
WHERE id = @id;