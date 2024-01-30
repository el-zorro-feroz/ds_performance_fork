import 'package:equatable/equatable.dart';

/// Responsible to store user [message] and possible [StackTrace] on fails.
final class Failure extends Equatable {
  /// Creates an instance of [Failure]
  const Failure({
    required this.message,
    this.stackTrace,
  });

  /// User message
  final String message;

  /// Possible trace for debugging
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message];
}
