import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/types/fail_or.dart';

/// A base class that allows us to create convenient interfaces
/// whose method will return an optional response.
abstract class UseCase<T, P> {
  /// Method that will return an optional response as an [Failure]
  /// or [T] accepting [P] as a request data
  FFailOr<T> call(P data);
}
