import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';

class SensorRule extends Equatable {
  final String id;
  final RuleType ruleType;
  final double value;

  const SensorRule({
    required this.id,
    required this.ruleType,
    required this.value,
  });

  @override
  List<Object?> get props => [
        id,
        ruleType,
        value,
      ];

  SensorRule copyWith({
    String? id,
    RuleType? ruleType,
    double? value,
  }) {
    return SensorRule(
      id: id ?? this.id,
      ruleType: ruleType ?? this.ruleType,
      value: value ?? this.value,
    );
  }
}
