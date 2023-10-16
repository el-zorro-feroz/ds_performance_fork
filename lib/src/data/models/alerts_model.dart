class AlertsModel {
  final String id;
  final String sensorId;
  final String ruleId;
  final String message;

  AlertsModel({
    required this.id,
    required this.sensorId,
    required this.ruleId,
    required this.message,
  });

  AlertsModel copyWith({
    String? id,
    String? sensorId,
    String? ruleId,
    String? message,
  }) {
    return AlertsModel(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      ruleId: ruleId ?? this.ruleId,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensorId': sensorId,
      'ruleId': ruleId,
      'message': message,
    };
  }

  factory AlertsModel.fromMap(Map<String, dynamic> map) {
    return AlertsModel(
      id: map['id'] as String,
      sensorId: map['sensorId'] as String,
      ruleId: map['ruleId'] as String,
      message: map['message'] as String,
    );
  }

  @override
  String toString() {
    return 'AlertsModel(id: $id, sensorId: $sensorId, ruleId: $ruleId, message: $message)';
  }
}
