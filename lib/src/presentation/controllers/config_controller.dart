import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
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
}
