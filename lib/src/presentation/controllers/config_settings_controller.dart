// ignore_for_file: use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/add_config_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/delete_config_by_id_usecase.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/edit_config_usecase.dart';
import 'package:sensors_monitoring/src/presentation/controllers/config_controller.dart';
import 'package:sensors_monitoring/src/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:uuid/uuid.dart';

@Injectable()
class ConfigSettingsController with ChangeNotifier {
  final AddConfigUsecase addConfigUsecase;
  final EditConfigUsecase editConfigUsecase;
  final DeleteConfigByIdUsecase deleteConfigByIdUsecase;

  late final String? configId;
  late Config config;

  late bool _isNewConfig = false;

  ConfigSettingsController({
    required this.addConfigUsecase,
    required this.editConfigUsecase,
    required this.deleteConfigByIdUsecase,
  });

  Future<void> initConfig([String? id]) async {
    if (id != null) {
      final ConfigController configController = services.get<ConfigController>();
      configId = id;
      config = await configController.getConfigData(id);
    } else {
      final String configId = const Uuid().v4();

      config = Config(
        id: configId,
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

  void onRemoveConfigurationPressed(BuildContext context) async {
    final bool confirmDeleting = await deleteConfirmationDialog(context);
    //TODO: define [DeleteConfigByIdUsecase] call

    GoRouter.of(context).go('/');
  }

  void onSaveConfigurationPressed(BuildContext context) {
    if (_isNewConfig) {
      //TODO: define [AddConfigUsecase] call
    } else {
      //TODO: define [EditConfigUsecase] call
    }

    // Be sure that creating\updating was call correctly
    GoRouter.of(context).go('/config/$configId');
  }

  //TODO: implement logic
  editSensorTitleByID(BuildContext context, int sensorIndex) {}
  deleteSensorByID(BuildContext context, int sensorIndex) {}
  changeSensorTypeByID(BuildContext context, int sensorIndex, SensorType type) {}
  editAlertByIndex(BuildContext context, int alertIndex) {}
  deleteAlertByIndex(BuildContext context, int alertIndex) {}
}
