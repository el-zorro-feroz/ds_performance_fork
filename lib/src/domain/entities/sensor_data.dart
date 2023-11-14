import 'package:equatable/equatable.dart';

class SensorData extends Equatable {
  final String id;
  final DateTime date;
  final double value;

  @override
  List<Object?> get props => [id];

  const SensorData({
    required this.id,
    required this.date,
    required this.value,
  });
}
