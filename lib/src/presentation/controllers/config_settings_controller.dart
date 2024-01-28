// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/core/failure/failure.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/delete_config_by_id_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/edit_config_usecase.dart';
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/sensor_rule_selector_dialog.dart';
import 'package:uuid/uuid.dart';

@Injectable()
class ConfigSettingsController with ChangeNotifier {
  final AddConfigUsecase addConfigUsecase;
  final EditConfigUsecase editConfigUsecase;
  final DeleteConfigByIdUsecase deleteConfigByIdUsecase;

  late String? configId;
  late Config config;

  late bool _isNewConfig = false;

  ConfigSettingsController({
    required this.addConfigUsecase,
    required this.editConfigUsecase,
    required this.deleteConfigByIdUsecase,
  });

  void initConfig([String? id]) {
    if (id != null) {
      final ConfigController configController = services.get<ConfigController>();
      configId = id;
      config = configController.getConfigData(id);
    } else {
      configId = const Uuid().v4();

      config = Config(
        id: configId!,
        title: 'New Configuration',
        tabList: const [],
        sensorList: const [],
      );

      _isNewConfig = true;
    }

    notifyListeners();
  }

  //TODO: implement logic
  Future<void> updateTitle() async {}
  Future<void> updateTabList() async {}
  Future<void> updateSensorList() async {}

  Future<void> onRemoveConfigurationPressed(BuildContext context) async {
    final bool confirmDeleting = await deleteConfirmationDialog(context);
    if (confirmDeleting) return;

    if (configId != null) {
      final Either<Failure, Unit> failOrUnit = await deleteConfigByIdUsecase.call(configId!);

      failOrUnit.fold(
        (failure) => _showDebugFailureSnack(context, failure),
        (unit) => GoRouter.of(context).go('/'),
      );

      services<ConfigController>().removeConfigById(configId!);

      configId = null;

      notifyListeners();
    }
  }

  Future<void> onSaveConfigurationPressed(BuildContext context) async {
    late final Either<Failure, Config> failOrConfig;

    if (_isNewConfig) {
      failOrConfig = await addConfigUsecase.call(
        AddConfigUsecaseParams(
          title: 'title', //TODO
          sensorList: [],
        ),
      );
    } else {
      failOrConfig = await editConfigUsecase.call(
        EditConfigUsecaseParams(
          config: config,
          editedSensorsList: [],
        ),
      );
    }

    failOrConfig.fold(
      (failure) => _showDebugFailureSnack(context, failure),
      (config) {
        services<ConfigController>().addConfig(config: config);
        GoRouter.of(context).go('/config/${config.id}');
      },
    );
  }

  void editSensorTitleByID(BuildContext context, int sensorIndex) {
    //TODO: dialog box or text-to-textbox pass
  }

  void deleteSensorByID(BuildContext context, int sensorIndex) {
    config = config.copyWith(
      sensorList: List.from(config.sensorList).removeAt(sensorIndex),
    );

    notifyListeners();
  }

  void changeSensorTypeByID(BuildContext context, int sensorIndex, SensorType type) {
    config = config.copyWith(
      sensorList: List<SensorInfo>.from(config.sensorList)
        //TOOD: recheck replacement on ui
        ..replaceRange(
          sensorIndex,
          sensorIndex,
          [config.sensorList.elementAt(sensorIndex).copyWith(sensorType: type)],
        ),
    );

    notifyListeners();
  }

  void addAlert(BuildContext context) async {
    await showSensorRuleSelectorDialog(
      context,
      initialAlertData: AlertData(
        id: const Uuid().v4(),
        title: '',
        message: '',
        description: '',
        type: AlertType.info,
        sensorRuleList: const [],
      ),
      onCompleteEditing: (AlertData data) async {},
    );
  }

  void editAlertByIndex(BuildContext context, int alertIndex) {}

  void deleteAlertByIndex(BuildContext context, int alertIndex) {}

  void _showDebugFailureSnack(BuildContext context, Failure failure) {
    if (kDebugMode) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${failure.runtimeType}:${failure.message}',
          ),
        ),
      );
    }
  }
}
