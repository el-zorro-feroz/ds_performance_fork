INSERT INTO sensorhistory (sensor_id, date, value)
-- 1 pos - sensor_id uuid
-- 2 pos - date timestamp
-- 3 pos - value real
VALUES(@sensor_id, @date, @value);