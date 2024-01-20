SELECT id as alert_id, sensor_id, rule_groups_data.rule_group_id, sensor_rules_data.sensor_rule_id, message, sensor_rules_data.type, sensor_rules_data.value, title, description, alerts.type as alert_type
FROM alerts
JOIN (
  SELECT id as rule_group_id, alert_id, rule_id
  FROM rulegroups
) AS rule_groups_data
ON rule_groups_data.alert_id = alerts.id
JOIN (
  SELECT id as sensor_rule_id, type, value
  FROM sensorrules
) AS sensor_rules_data
ON sensor_rules_data.sensor_rule_id = rule_groups_data.rule_id
WHERE alerts.sensor_id = @sensor_id;