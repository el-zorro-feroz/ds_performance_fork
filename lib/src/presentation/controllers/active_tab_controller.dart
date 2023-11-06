import 'dart:async';
import 'dart:developer';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ActiveTabController with ChangeNotifier {
  bool _isReady = false;
  bool get isReady => _isReady;

  FutureOr<void> loadTab(String id) async {
    log('Loading Tab #($id)', name: runtimeType.toString());
    Future.delayed(const Duration(seconds: 1), () => _isReady = true);
    notifyListeners();
  }
}
