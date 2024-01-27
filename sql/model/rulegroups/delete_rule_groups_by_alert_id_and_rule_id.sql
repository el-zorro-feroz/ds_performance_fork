DELETE FROM rulegroups 
WHERE alert_id = @alert_id AND rule_id = @rule_id;