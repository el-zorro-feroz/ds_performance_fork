import 'package:equatable/equatable.dart';

class SensorRule extends Equatable {
  final String id;
  final String sensorId;
  final String ruleId;
  final double value;

  const SensorRule({
    required this.id,
    required this.sensorId,
    required this.ruleId,
    required this.value,
  });

  @override
  List<Object?> get props => [id];
}
