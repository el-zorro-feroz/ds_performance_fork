UPDATE graphsensors 
-- graphs_id uuid
-- sensor_id uuid
SET graphs_id = COALESCE(@graphs_id, graphs_id),
    sensor_id = COALESCE(@sensor_id, sensor_id)
-- id uuid
WHERE id = @id;

