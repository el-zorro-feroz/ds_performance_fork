import 'package:sensors_monitoring/core/enum/rule_type.dart';

class SensorRulesModel {
  final String id;
  final RuleType ruleType;
  final double value;

  const SensorRulesModel({
    required this.id,
    required this.ruleType,
    required this.value,
  });

  SensorRulesModel copyWith({
    String? id,
    RuleType? ruleType,
    double? value,
  }) {
    return SensorRulesModel(
      id: id ?? this.id,
      ruleType: ruleType ?? this.ruleType,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': ruleType,
      'value': value,
    };
  }

  factory SensorRulesModel.fromMap(Map<String, dynamic> map) {
    return SensorRulesModel(
      id: map['id'] as String,
      ruleType: RuleType.values.byName(map['type']),
      value: map['value'] as double,
    );
  }

  @override
  String toString() => 'SensorsRules(id: $id, ruleType: $ruleType, value: $value)';
}
