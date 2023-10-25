UPDATE graphssensors 
-- graphs_id uuid
-- sensor_id uuid
SET graphsId = ?,
    sensorIs = ?
-- id uuid
WHERE id = @id;
