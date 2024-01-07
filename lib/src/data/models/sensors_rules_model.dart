class SensorRulesModel {
  final String id;
  final String sensorId;
  final String ruleId;
  final double value;

  const SensorRulesModel({
    required this.id,
    required this.sensorId,
    required this.ruleId,
    required this.value,
  });

  SensorRulesModel copyWith({
    String? id,
    String? sensorId,
    String? ruleId,
    double? value,
  }) {
    return SensorRulesModel(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      ruleId: ruleId ?? this.ruleId,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensor_id': sensorId,
      'rule_id': ruleId,
      'value': value,
    };
  }

  factory SensorRulesModel.fromMap(Map<String, dynamic> map) {
    return SensorRulesModel(
      id: map['id'] as String,
      sensorId: map['sensor_id'] as String,
      ruleId: map['rule_id'] as String,
      value: map['value'] as double,
    );
  }

  @override
  String toString() => 'SensorsRules(id: $id, sensorId: $sensorId, ruleId: $ruleId, value: $value)';
}
