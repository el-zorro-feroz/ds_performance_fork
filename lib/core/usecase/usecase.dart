import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';

abstract class UseCase<T, P> {
  FutureOr<Either<Failure, T>> call(P param);
}
