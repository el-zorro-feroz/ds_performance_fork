// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sensors_monitoring/core/services/services.dart' as _i7;
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart'
    as _i12;
import 'package:sensors_monitoring/src/data/repositories/config_repository_impl.dart'
    as _i14;
import 'package:sensors_monitoring/src/data/repositories/sensor_repository_impl.dart'
    as _i9;
import 'package:sensors_monitoring/src/data/repositories/tab_repository_impl.dart'
    as _i11;
import 'package:sensors_monitoring/src/domain/repositories/alert_repository.dart'
    as _i4;
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart'
    as _i13;
import 'package:sensors_monitoring/src/domain/repositories/sensor_repository.dart'
    as _i8;
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart'
    as _i10;
import 'package:sensors_monitoring/src/domain/usecases/alert/get_alerts_usecase.dart'
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
    gh.factory<_i4.AlertRepository>(
        () => _i4.UnimplementedNotificationRepository());
    gh.factory<_i5.GetAlertsUseCase>(
        () => _i5.GetAlertsUseCase(alertRepository: gh<_i4.AlertRepository>()));
    gh.singleton<_i6.NotificationController>(_i6.NotificationController(
        getNotificationsUseCase: gh<_i5.GetAlertsUseCase>()));
    gh.singleton<_i7.PostgresModule>(_i7.PostgresModule());
    gh.factory<_i8.SensorRepository>(() => _i9.SensorRepositoryImpl());
    gh.factory<_i10.TabRepository>(() => _i11.TabRepositoryImpl());
    gh.factory<_i12.CommonDatasource>(
        () => _i12.CommonDatasource(postgresModule: gh<_i7.PostgresModule>()));
    gh.factory<_i13.ConfigRepository>(() =>
        _i14.ConfigRepositoryImpl(datasource: gh<_i12.CommonDatasource>()));
    return this;
  }
}
