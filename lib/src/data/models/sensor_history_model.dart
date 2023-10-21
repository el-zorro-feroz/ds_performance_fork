class SensorHistoryModel {
  final String id;
  final String sensorId;
  final DateTime date;
  final double value;

  const SensorHistoryModel({
    required this.id,
    required this.sensorId,
    required this.date,
    required this.value,
  });

  SensorHistoryModel copyWith({
    String? id,
    String? sensorId,
    DateTime? date,
    double? value,
  }) {
    return SensorHistoryModel(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensorId': sensorId,
      'date': date.toIso8601String(),
      'value': value,
    };
  }

  factory SensorHistoryModel.fromMap(Map<String, dynamic> map) {
    return SensorHistoryModel(
      id: map['id'] as String,
      sensorId: map['sensorId'] as String,
      date: DateTime.parse(map['date']),
      value: map['value'] as double,
    );
  }

  @override
  String toString() {
    return 'SensorHistoryModel(id: $id, sensorId: $sensorId, date: $date, value: $value)';
  }
}
