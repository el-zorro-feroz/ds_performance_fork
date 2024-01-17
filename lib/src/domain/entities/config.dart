import 'package:equatable/equatable.dart';
import 'package:sensors_monitoring/src/domain/entities/tab.dart';

class Config extends Equatable {
  final String id;
  final String title;
  final List<Tab> tabList;
  const Config({
    required this.id,
    required this.title,
    required this.tabList,
  });

  @override
  List<Object?> get props => [id];
}
