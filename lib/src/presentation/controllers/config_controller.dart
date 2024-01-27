import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/get_all_configs_usecase.dart';

@Singleton()
class ConfigController with ChangeNotifier {
  final GetAllConfigsUseCase getAllConfigsUseCase;

  ConfigController({required this.getAllConfigsUseCase});

  List<Config> configs = [];

  Future<void> fetchAllConfigs() async {
    final resultOrFailure = await getAllConfigsUseCase.call(unit);

    resultOrFailure.fold(
      (failure) {
        debugPrint('${failure.runtimeType}: ${failure.message}');
      },
      (data) {
        configs = data;

        notifyListeners();
      },
    );
  }

  Map<String, String> getConfigTileData() {
    try {
      final entries = configs.map((config) {
        return MapEntry(config.id, config.title);
      });

      return Map.fromEntries(entries);
    } catch (_) {
      return {};
    }
  }

  Config getConfigData(String id) {
    try {
      return configs.firstWhere((config) => config.id == id, orElse: () {
        throw Exception('Called missing configuration');
      });
    } catch (_) {
      throw Exception('Configuration fetch error');
    }
  }

  Future<SensorInfo> getSensorDataDetails(String configID, String sensorID) async {
    try {
      final config = getConfigData(configID);
      return config.sensorList.firstWhere(
        (sensor) {
          return sensor.id == sensorID;
        },
        orElse: () => throw Exception('Sensor fetch error'),
      );
    } catch (_) {
      throw Exception('Configuration fetch error');
    }
  }
}
