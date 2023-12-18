import 'dart:async';
import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ActiveTabController with ChangeNotifier {
  bool _isReady = true;
  bool get isReady => _isReady;

  FutureOr<void> loadTab(String id) async {
    log('Loading Tab #($id)', name: runtimeType.toString());
    _isReady = true;
    // _isReady = false;
    // notifyListeners();

    // await Future.delayed(const Duration(seconds: 3), () => _isReady = true);
    // notifyListeners();
  }
}
