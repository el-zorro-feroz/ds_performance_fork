class RuleGroupsModel {
  final String id;
  final String alertId;
  final String ruleId;

  const RuleGroupsModel({
    required this.id,
    required this.alertId,
    required this.ruleId,
  });

  RuleGroupsModel copyWith({
    String? id,
    String? alertId,
    String? ruleId,
  }) {
    return RuleGroupsModel(
      id: id ?? this.id,
      alertId: alertId ?? this.alertId,
      ruleId: ruleId ?? this.ruleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'alertId': alertId,
      'ruleId': ruleId,
    };
  }

  factory RuleGroupsModel.fromMap(Map<String, dynamic> map) {
    return RuleGroupsModel(
      id: map['id'] as String,
      alertId: map['alert_id'] as String,
      ruleId: map['rule_id'] as String,
    );
  }

  @override
  String toString() => 'RuleGroupsModel(id: $id, alertId: $alertId, ruleId: $ruleId)';
}
