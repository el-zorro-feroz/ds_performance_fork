import 'package:equatable/equatable.dart';

class TabSensor extends Equatable {
  final String id;
  final String sensorId;
  final String tabId;

  const TabSensor({
    required this.id,
    required this.sensorId,
    required this.tabId,
  });

  @override
  List<Object?> get props => [id];
}
