class TabSensorsModel {
  final String id;
  final String sensorId;
  final String tabId;

  const TabSensorsModel({
    required this.id,
    required this.sensorId,
    required this.tabId,
  });

  TabSensorsModel copyWith({
    String? id,
    String? sensorId,
    String? tabId,
  }) {
    return TabSensorsModel(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      tabId: tabId ?? this.tabId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sensorId': sensorId,
      'tabId': tabId,
    };
  }

  factory TabSensorsModel.fromMap(Map<String, dynamic> map) {
    return TabSensorsModel(
      id: map['id'] as String,
      sensorId: map['sensorId'] as String,
      tabId: map['tabId'] as String,
    );
  }

  @override
  String toString() {
    return 'TabSensrosModel(id: $id, sensorId: $sensorId, tabId: $tabId)';
  }
}
