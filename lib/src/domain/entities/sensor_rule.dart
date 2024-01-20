import 'package:equatable/equatable.dart';

class SensorRule extends Equatable {
  final String decription;
  final double value;
  final String ruleID;

  const SensorRule({
    required this.decription,
    required this.value,
    required this.ruleID,
  });

  @override
  List<Object?> get props => [
        decription,
        value,
      ];
}
