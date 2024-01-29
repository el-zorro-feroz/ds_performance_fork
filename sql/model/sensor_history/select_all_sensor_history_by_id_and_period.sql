SELECT *
FROM sensorhistory
-- beginning_period - start of period timestamp
-- beginning_period - end of period timestamp
-- sensor_id uuid
WHERE sensor_id = @sensor_id
AND @beginning_period <= date 
AND date <= @ending_period
ORDER BY date;