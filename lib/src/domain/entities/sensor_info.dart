import 'package:equatable/equatable.dart';

class SensorInfo extends Equatable {
  final String id;
  final String configId;
  final String tabName;
  final String title;
  final String details;

  const SensorInfo(
    this.tabName, {
    required this.id,
    required this.configId,
    required this.title,
    required this.details,
  });

  @override
  List<Object?> get props => [id];
}
