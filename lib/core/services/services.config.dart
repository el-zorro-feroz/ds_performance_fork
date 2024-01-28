// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sensors_monitoring/core/services/services.dart' as _i6;
import 'package:sensors_monitoring/src/data/datasources/common_datasource.dart'
    as _i9;
import 'package:sensors_monitoring/src/data/repositories/config_repository_impl.dart'
    as _i11;
import 'package:sensors_monitoring/src/data/repositories/sensor_repository_impl.dart'
    as _i8;
import 'package:sensors_monitoring/src/data/repositories/tab_repository_impl.dart'
    as _i16;
import 'package:sensors_monitoring/src/domain/repositories/alert_repository.dart'
    as _i3;
import 'package:sensors_monitoring/src/domain/repositories/config_repository.dart'
    as _i10;
import 'package:sensors_monitoring/src/domain/repositories/sensor_repository.dart'
    as _i7;
import 'package:sensors_monitoring/src/domain/repositories/tab_repository.dart'
    as _i15;
import 'package:sensors_monitoring/src/domain/usecases/alert/get_alerts_usecase.dart'
    as _i4;
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart'
    as _i17;
import 'package:sensors_monitoring/src/domain/usecases/configs/delete_config_by_id_usecase.dart'
    as _i12;
import 'package:sensors_monitoring/src/domain/usecases/configs/edit_config_usecase.dart'
    as _i13;
import 'package:sensors_monitoring/src/domain/usecases/configs/get_all_configs_usecase.dart'
    as _i14;
import 'package:sensors_monitoring/src/domain/usecases/tab/add_tab_usecase.dart'
    as _i18;
import 'package:sensors_monitoring/src/domain/usecases/tab/delete_tab_by_id_usecase.dart'
    as _i21;
import 'package:sensors_monitoring/src/domain/usecases/tab/edit_tab_usecase.dart'
    as _i22;
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart'
    as _i19;
import 'package:sensors_monitoring/src/presentation/controllers/config_settings_controller.dart'
    as _i20;
import 'package:sensors_monitoring/src/presentation/controllers/notification_controller.dart'
    as _i5;
import 'package:sensors_monitoring/src/presentation/controllers/tab_controller.dart'
    as _i23;

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
    gh.factory<_i3.AlertRepository>(
        () => _i3.UnimplementedNotificationRepository());
    gh.factory<_i4.GetAlertsUseCase>(
        () => _i4.GetAlertsUseCase(alertRepository: gh<_i3.AlertRepository>()));
    gh.singleton<_i5.NotificationController>(_i5.NotificationController(
        getNotificationsUseCase: gh<_i4.GetAlertsUseCase>()));
    gh.singleton<_i6.PostgresModule>(_i6.PostgresModule());
    gh.factory<_i7.SensorRepository>(() => _i8.SensorRepositoryImpl());
    gh.factory<_i9.CommonDatasource>(
        () => _i9.CommonDatasource(postgresModule: gh<_i6.PostgresModule>()));
    gh.factory<_i10.ConfigRepository>(() =>
        _i11.ConfigRepositoryImpl(datasource: gh<_i9.CommonDatasource>()));
    gh.factory<_i12.DeleteConfigByIdUsecase>(() => _i12.DeleteConfigByIdUsecase(
        configRepository: gh<_i10.ConfigRepository>()));
    gh.factory<_i13.EditConfigUsecase>(
        () => _i13.EditConfigUsecase(repository: gh<_i10.ConfigRepository>()));
    gh.factory<_i14.GetAllConfigsUseCase>(() => _i14.GetAllConfigsUseCase(
        configRepository: gh<_i10.ConfigRepository>()));
    gh.factory<_i15.TabRepository>(
        () => _i16.TabRepositoryImpl(datasource: gh<_i9.CommonDatasource>()));
    gh.factory<_i17.AddConfigUsecase>(() =>
        _i17.AddConfigUsecase(configRepository: gh<_i10.ConfigRepository>()));
    gh.factory<_i18.AddTabUsecase>(
        () => _i18.AddTabUsecase(tabRepository: gh<_i15.TabRepository>()));
    gh.singleton<_i19.ConfigController>(_i19.ConfigController(
        getAllConfigsUseCase: gh<_i14.GetAllConfigsUseCase>()));
    gh.factory<_i20.ConfigSettingsController>(
        () => _i20.ConfigSettingsController(
              addConfigUsecase: gh<_i17.AddConfigUsecase>(),
              editConfigUsecase: gh<_i13.EditConfigUsecase>(),
              deleteConfigByIdUsecase: gh<_i12.DeleteConfigByIdUsecase>(),
            ));
    gh.factory<_i21.DeleteTabByIdUsecase>(() =>
        _i21.DeleteTabByIdUsecase(tabRepository: gh<_i15.TabRepository>()));
    gh.factory<_i22.EditTabUsecase>(
        () => _i22.EditTabUsecase(tabRepository: gh<_i15.TabRepository>()));
    gh.factory<_i23.TabController>(
        () => _i23.TabController(addTabUsecase: gh<_i18.AddTabUsecase>()));
    return this;
  }
}
