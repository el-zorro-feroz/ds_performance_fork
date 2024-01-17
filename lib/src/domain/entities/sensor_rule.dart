import 'package:equatable/equatable.dart';

class SensorRule extends Equatable {
  final String title;
  final double avgValue; //!
  final double maxValue;
  final double minValue;

  const SensorRule({
    required this.title,
    required this.avgValue,
    required this.maxValue,
    required this.minValue,
  });

  @override
  List<Object?> get props => [
        title,
        minValue,
        maxValue,
      ];
}
