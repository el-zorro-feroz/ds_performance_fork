import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/src/domain/entities/notification_data.dart';
import 'package:sensors_monitoring/src/domain/usecases/notification/get_notifications_usecase.dart';

@Singleton()
class NotificationController with ChangeNotifier {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationController({
    required this.getNotificationsUseCase,
  });

  Timer? timer;
  Iterable<NotificationData> notifications = [];

  void fetchNotifications() {
    const Duration duration = Duration(minutes: 1);

    _updateNotifications();
    timer = Timer.periodic(duration, (timer) {
      _updateNotifications();
    });
  }

  Future<void> _updateNotifications() async {
    const GetNotificationsUseCaseParam getNotificationsUseCaseParam = GetNotificationsUseCaseParam(count: 15);
    final Either<Failure, Iterable<NotificationData>> notificationsOrFailiure = await getNotificationsUseCase.call(getNotificationsUseCaseParam);

    notificationsOrFailiure.fold(
      (Failure failure) {
        //! Show Alert SnackBar
      },
      (Iterable<NotificationData> data) {
        if (notifications.hashCode == data.hashCode) return;
        notifications = data;

        notifyListeners();
      },
    );
  }
}
