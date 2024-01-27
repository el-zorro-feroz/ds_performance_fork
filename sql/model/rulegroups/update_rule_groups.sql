UPDATE rulegroups
SET alert_id = COALESCE (@alert_id, alert_id),
	rule_id = COALESCE (@rule_id, rule_id),
-- id uuid
WHERE id = @id;