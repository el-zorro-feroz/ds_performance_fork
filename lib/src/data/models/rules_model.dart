// class RulesModel {
//   final String id;
//   final String description;

//   const RulesModel({
//     required this.id,
//     required this.description,
//   });

//   RulesModel copyWith({
//     String? id,
//     String? description,
//   }) {
//     return RulesModel(
//       id: id ?? this.id,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'description': description,
//     };
//   }

//   factory RulesModel.fromMap(Map<String, dynamic> map) {
//     return RulesModel(
//       id: map['id'] as String,
//       description: map['description'] as String,
//     );
//   }

//   @override
//   String toString() => 'RulesModel(id: $id, description: $description)';
// }
