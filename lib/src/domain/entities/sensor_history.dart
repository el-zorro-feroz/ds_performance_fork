import 'package:equatable/equatable.dart';

class SensorHistory extends Equatable {
  final String id;
  final DateTime date;
  final double value;

  const SensorHistory({
    required this.id,
    required this.date,
    required this.value,
  });

  @override
  List<Object?> get props => [id];
}
