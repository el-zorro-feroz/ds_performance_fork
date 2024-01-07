// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sensors_monitoring/src/domain/repositories/notification_repository.dart'
    as _i4;
import 'package:sensors_monitoring/src/domain/usecases/notification/get_notifications_usecase.dart'
    as _i5;
import 'package:sensors_monitoring/src/presentation/controllers/notification_controller.dart'
    as _i6;
import 'package:sensors_monitoring/src/presentation/widgets/config_page/active_tab.dart'
    as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.ActiveTab>(_i3.ActiveTab());
    gh.factory<_i4.NotificationRepository>(
        () => _i4.UnimplementedNotificationRepository());
    gh.factory<_i5.GetNotificationsUseCase>(() => _i5.GetNotificationsUseCase(
        notificationRepository: gh<_i4.NotificationRepository>()));
    gh.singleton<_i6.NotificationController>(_i6.NotificationController(
        getNotificationsUseCase: gh<_i5.GetNotificationsUseCase>()));
    return this;
  }
}
