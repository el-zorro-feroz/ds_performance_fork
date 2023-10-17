import 'package:sensors_monitoring/src/data/models/enum/graph_dependency.dart';
import 'package:sensors_monitoring/src/data/models/enum/graph_type.dart';

class GraphsModel {
  final String id;
  final GraphType type;
  final GraphDependency dependency;

  GraphsModel({
    required this.id,
    required this.type,
    required this.dependency,
  });

  GraphsModel copyWith({
    String? id,
    GraphType? type,
    GraphDependency? dependency,
  }) {
    return GraphsModel(
      id: id ?? this.id,
      type: type ?? this.type,
      dependency: dependency ?? this.dependency,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'dependency': dependency.name,
    };
  }

  factory GraphsModel.fromMap(Map<String, dynamic> map) {
    return GraphsModel(
      id: map['id'] as String,
      type: GraphType.values.where((element) => element == map['type']).first,
      dependency: GraphDependency.values.where((element) => element == map['dependency']).first,
    );
  }

  @override
  String toString() => 'GraphsModel(id: $id, type: $type, dependency: $dependency)';
}
