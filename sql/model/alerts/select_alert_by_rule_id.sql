SELECT * 
FROM alerts
-- rule_id uuid
WHERE rule_id = @rule_id;