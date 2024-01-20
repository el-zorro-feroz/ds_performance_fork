-- SELECT * 
-- FROM alerts
-- JOIN sensorrules
-- ON alerts.rule_id = sensorrules.id
-- WHERE sensor_id = @sensor_id
SELECT * 
FROM (SELECT *
      FROM alerts
      WHERE sensor_id = @sensor_id)
    as al
JOIN sensorrules
ON al.rule_id = sensorrules.id
