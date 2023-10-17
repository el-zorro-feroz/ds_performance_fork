class SensorsModel {
  final String id;
  final String configId;
  final String title;

  SensorsModel({
    required this.id,
    required this.configId,
    required this.title,
  });

  SensorsModel copyWith({
    String? id,
    String? configId,
    String? title,
  }) {
    return SensorsModel(
      id: id ?? this.id,
      configId: configId ?? this.configId,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'configId': configId,
      'title': title,
    };
  }

  factory SensorsModel.fromMap(Map<String, dynamic> map) {
    return SensorsModel(
      id: map['id'] as String,
      configId: map['configId'] as String,
      title: map['title'] as String,
    );
  }

  @override
  String toString() {
    return 'SensorModel(id: $id, configId: $configId, title: $title)';
  }
}
