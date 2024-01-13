import 'package:equatable/equatable.dart';

class Tab extends Equatable {
  final String id;
  final String configId;
  final String title;

  const Tab({
    required this.id,
    required this.configId,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
