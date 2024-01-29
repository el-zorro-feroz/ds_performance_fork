// ignore_for_file: use_build_context_synchronously

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
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
  late Config savedConfig;

  late bool _isNewConfig = false;

  ConfigSettingsController({
    required this.addConfigUsecase,
    required this.editConfigUsecase,
    required this.deleteConfigByIdUsecase,
  });

  final TextEditingController titleEditingController = TextEditingController();

  void initConfig([String? id]) {
    try {
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
      savedConfig = config;
    } catch (_) {
      configId = null;
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
        (unit) {
          services<ConfigController>().removeConfigById(configId!);
          GoRouter.of(context).go('/');
        },
      );

      notifyListeners();
    }
  }

  Future<void> onSaveConfigurationPressed(BuildContext context) async {
    late final Either<Failure, Config> failOrConfig;

    if (_isNewConfig) {
      failOrConfig = await addConfigUsecase.call(
        AddConfigUsecaseParams(
          title: config.title,
          sensorList: config.sensorList,
        ),
      );
    } else {
      failOrConfig = await editConfigUsecase.call(
        EditConfigUsecaseParams(
          config: savedConfig,
          editedSensorsList: config.sensorList,
          title: config.title,
        ),
      );
    }

    failOrConfig.fold(
      (failure) => _showDebugFailureSnack(context, failure),
      (config) {
        this.config = config;
        services<ConfigController>().addConfig(config: config);
        GoRouter.of(context).go('/config/${config.id}');
      },
    );

    notifyListeners();
  }

  void addSensor() {
    config = config.copyWith(
      sensorList: List.from(config.sensorList)
        ..add(
          SensorInfo(
            id: const Uuid().v4(),
            title: 'New sensor',
            details: '',
            sensorType: SensorType.temperature,
            sensorHistoryList: const [],
            alerts: const [],
          ),
        ),
    );
    notifyListeners();
  }

  void editSensorDetailsByID(BuildContext context, int sensorIndex) {}

  void deleteSensorByID(BuildContext context, int sensorIndex) {
    config = config.copyWith(
      sensorList: List.from(config.sensorList)..removeAt(sensorIndex),
    );

    notifyListeners();
  }

  void changeSensorTypeByID(BuildContext context, int sensorIndex, SensorType type) {
    config = config.copyWith(
        sensorList: List<SensorInfo>.from(config.sensorList)
          ..removeAt(sensorIndex)
          ..insert(
            sensorIndex,
            config.sensorList.elementAt(sensorIndex).copyWith(sensorType: type, title: type.name), //TODO
          ));

    notifyListeners();
  }

  void addAlert(BuildContext context, int sensorIndex) async {
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
      onCompleteEditing: (AlertData data) async {
        print(data);
        if (data.sensorRuleList.isEmpty) {
          return;
        }
        final sensorRuleList = [...data.sensorRuleList];
        for (var element in sensorRuleList) {
          sensorRuleList.remove(element);
          sensorRuleList.add(element.copyWith(id: ''));
        }

        data = data.copyWith(sensorRuleList: sensorRuleList);
        List<AlertData> alertList = [...config.sensorList.elementAt(sensorIndex).alerts];
        alertList.add(data);
        List<SensorInfo> sensorList = List.from(config.sensorList)
          ..removeAt(sensorIndex)
          ..insert(sensorIndex, config.sensorList.elementAt(sensorIndex).copyWith(alerts: alertList));

        config = config.copyWith(sensorList: sensorList);

        GoRouter.of(context).pop();

        notifyListeners();
      },
    );
  }

  void editAlertByIndex(BuildContext context, int alertIndex, int sensorIndex) {}

  void deleteAlertByIndex(BuildContext context, int alertIndex, int sensorIndex) {
    List<AlertData> alertList = [...config.sensorList.elementAt(sensorIndex).alerts];
    alertList.removeAt(alertIndex);
    List<SensorInfo> sensorList = List.from(config.sensorList)
      ..removeAt(sensorIndex)
      ..insert(
        sensorIndex,
        config.sensorList.elementAt(sensorIndex).copyWith(alerts: alertList),
      );

    config = config.copyWith(sensorList: sensorList);

    notifyListeners();
  }

  void _showDebugFailureSnack(BuildContext context, Failure failure) {
    if (kDebugMode) {
      debugPrint('${failure.runtimeType}:${failure.message}');
    }
  }

  void ontitleEditingComplete() {
    config = config.copyWith(title: titleEditingController.text);
    notifyListeners();
  }

  final Map<int, TextEditingController> _sensorTitleTextEditingControllers = {};

  void changeSensorTitleByIndex({required int sensorIndex}) {
    config = config.copyWith(
      sensorList: List.from(config.sensorList)
        ..removeAt(sensorIndex)
        ..insert(
          sensorIndex,
          config.sensorList.elementAt(sensorIndex).copyWith(
                title: _sensorTitleTextEditingControllers[sensorIndex]!.text,
              ),
        ),
    );
    notifyListeners();
  }

  TextEditingController getSensorTitleControllerByIndex({required int sensorIndex}) {
    if (_sensorTitleTextEditingControllers.containsKey(sensorIndex)) {
      return _sensorTitleTextEditingControllers[sensorIndex]!;
    }
    _sensorTitleTextEditingControllers.addEntries([
      MapEntry(
        sensorIndex,
        TextEditingController()..text = config.sensorList[sensorIndex].title,
      ),
    ]);

    return _sensorTitleTextEditingControllers[sensorIndex]!;
  }

  final Map<int, TextEditingController> _sensorDetailsTextEditingControllers = {};

  void changeSensorDetailsByIndex({required int sensorIndex}) {
    config = config.copyWith(
      sensorList: List.from(config.sensorList)
        ..removeAt(sensorIndex)
        ..insert(
          sensorIndex,
          config.sensorList.elementAt(sensorIndex).copyWith(
                details: _sensorDetailsTextEditingControllers[sensorIndex]!.text,
              ),
        ),
    );
    notifyListeners();
  }

  TextEditingController getSensorDetailsControllerByIndex({required int sensorIndex}) {
    if (_sensorDetailsTextEditingControllers.containsKey(sensorIndex)) {
      return _sensorDetailsTextEditingControllers[sensorIndex]!;
    }
    _sensorDetailsTextEditingControllers.addEntries([
      MapEntry(
        sensorIndex,
        TextEditingController()..text = config.sensorList[sensorIndex].details,
      ),
    ]);

    return _sensorDetailsTextEditingControllers[sensorIndex]!;
  }
}
