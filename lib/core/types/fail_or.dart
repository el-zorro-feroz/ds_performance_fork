import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';

/// Returns either [Failure] or a completition [Unit]
typedef FailOrUnit = Either<Failure, Unit>;

/// Returns either [Failure] or a completition [Unit] in [Future]
typedef FFailOrUnit = FutureOr<FailOrUnit>;

/// Returns either [Failure] or a completition [T]
typedef FailOr<T> = Either<Failure, T>;

/// Returns either [Failure] or a completition [T] in [Future]
typedef FFailOr<T> = FutureOr<FailOr<T>>;
