// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sensors_monitoring/src/domain/repositories/notification_repository.dart'
    as _i6;
import 'package:sensors_monitoring/src/domain/usecases/notification/get_notifications_usecase.dart'
    as _i7;
import 'package:sensors_monitoring/src/presentation/controllers/active_tab_controller.dart'
    as _i4;
import 'package:sensors_monitoring/src/presentation/controllers/configuration_controller.dart'
    as _i5;
import 'package:sensors_monitoring/src/presentation/controllers/notification_controller.dart'
    as _i8;
import 'package:sensors_monitoring/src/presentation/widgets/config/active_tab.dart'
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
    gh.singleton<_i4.ActiveTabController>(_i4.ActiveTabController());
    gh.singleton<_i5.ConfigurationController>(_i5.ConfigurationController());
    gh.factory<_i6.NotificationRepository>(
        () => _i6.UnimplementedNotificationRepository());
    gh.factory<_i7.GetNotificationsUseCase>(() => _i7.GetNotificationsUseCase(
        notificationRepository: gh<_i6.NotificationRepository>()));
    gh.singleton<_i8.NotificationController>(_i8.NotificationController(
        getNotificationsUseCase: gh<_i7.GetNotificationsUseCase>()));
    return this;
  }
}
