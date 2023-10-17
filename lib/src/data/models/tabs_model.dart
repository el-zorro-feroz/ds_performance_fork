class TabsModel {
  final String id;
  final String configId;
  final String title;

  TabsModel({
    required this.id,
    required this.configId,
    required this.title,
  });

  TabsModel copyWith({
    String? id,
    String? configId,
    String? title,
  }) {
    return TabsModel(
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

  factory TabsModel.fromMap(Map<String, dynamic> map) {
    return TabsModel(
      id: map['id'] as String,
      configId: map['configId'] as String,
      title: map['title'] as String,
    );
  }

  @override
  String toString() {
    return 'TabsModel(id: $id, configId: $configId, title: $title)';
  }
}
