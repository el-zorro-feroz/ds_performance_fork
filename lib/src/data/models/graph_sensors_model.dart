class GraphSensorsModel {
  final String id;
  final String graphsId;
  final String sensorsId;

  GraphSensorsModel({
    required this.id,
    required this.graphsId,
    required this.sensorsId,
  });

  GraphSensorsModel copyWith({
    String? id,
    String? graphsId,
    String? sensorsId,
  }) {
    return GraphSensorsModel(
      id: id ?? this.id,
      graphsId: graphsId ?? this.graphsId,
      sensorsId: sensorsId ?? this.sensorsId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'graphsId': graphsId,
      'sensorsId': sensorsId,
    };
  }

  factory GraphSensorsModel.fromMap(Map<String, dynamic> map) {
    return GraphSensorsModel(
      id: map['id'] as String,
      graphsId: map['graphsId'] as String,
      sensorsId: map['sensorsId'] as String,
    );
  }

  @override
  String toString() => 'GraphSensors(id: $id, graphsId: $graphsId, sensorsId: $sensorsId)';
}
