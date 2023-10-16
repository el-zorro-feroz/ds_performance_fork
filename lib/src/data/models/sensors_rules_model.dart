class SensorRulesModel {
  final String sensorId;
  final String ruleId;
  final double value;

  SensorRulesModel({
    required this.sensorId,
    required this.ruleId,
    required this.value,
  });

  SensorRulesModel copyWith({
    String? sensorId,
    String? ruleId,
    double? value,
  }) {
    return SensorRulesModel(
      sensorId: sensorId ?? this.sensorId,
      ruleId: ruleId ?? this.ruleId,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensorId': sensorId,
      'ruleId': ruleId,
      'value': value,
    };
  }

  factory SensorRulesModel.fromMap(Map<String, dynamic> map) {
    return SensorRulesModel(
      sensorId: map['sensorId'] as String,
      ruleId: map['ruleId'] as String,
      value: map['value'] as double,
    );
  }

  @override
  String toString() => 'SensorsRules(sensorId: $sensorId, ruleId: $ruleId, value: $value)';
}
