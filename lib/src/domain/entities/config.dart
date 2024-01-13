import 'package:equatable/equatable.dart';

class Config extends Equatable {
  final String id;
  final String title;

  const Config({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id];
}
