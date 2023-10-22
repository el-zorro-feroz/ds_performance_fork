class ConfigModel {
  final String id;
  final String title;

  const ConfigModel({
    required this.id,
    required this.title,
  });

  ConfigModel copyWith({
    String? id,
    String? title,
  }) {
    return ConfigModel(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory ConfigModel.fromMap(Map<String, dynamic> map) {
    return ConfigModel(
      id: map['id'] as String,
      title: map['title'] as String,
    );
  }

  @override
  String toString() {
    return 'ConfigsModel(id: $id, title: $title)';
  }
}
