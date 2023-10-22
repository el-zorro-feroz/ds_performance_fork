class GraphSensorsModel {
  final String id;
  final String graphsId;
  final String sensorId;

  const GraphSensorsModel({
    required this.id,
    required this.graphsId,
    required this.sensorId,
  });

  GraphSensorsModel copyWith({
    String? id,
    String? graphsId,
    String? sensorId,
  }) {
    return GraphSensorsModel(
      id: id ?? this.id,
      graphsId: graphsId ?? this.graphsId,
      sensorId: sensorId ?? this.sensorId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'graphsId': graphsId,
      'sensorId': sensorId,
    };
  }

  factory GraphSensorsModel.fromMap(Map<String, dynamic> map) {
    return GraphSensorsModel(
      id: map['id'] as String,
      graphsId: map['graphsId'] as String,
      sensorId: map['sensorId'] as String,
    );
  }

  @override
  String toString() => 'GraphSensorsModel(id: $id, graphsId: $graphsId, sensorId: $sensorId)';
}
