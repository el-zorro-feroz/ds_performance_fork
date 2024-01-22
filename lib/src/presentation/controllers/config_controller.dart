import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/src/domain/entities/config.dart';
import 'package:sensors_monitoring/src/domain/usecases/configs/get_all_configs_usecase.dart';

@Singleton()
class ConfigController with ChangeNotifier {
  final GetAllConfigsUsecase getAllConfigsUsecase;

  ConfigController({required this.getAllConfigsUsecase});

  List<Config> configList = [];

  void fetchAllConfigs() async {
    final resultOrFailure = await getAllConfigsUsecase.call(unit);

    resultOrFailure.fold(
      (l) {
        //! Show Alert SnackBar
      },
      (r) {
        configList = r;

        notifyListeners();
      },
    );
  }
}
