import 'package:fluent_ui/fluent_ui.dart';
import 'package:injectable/injectable.dart';
import 'package:sensors_monitoring/src/domain/usecases/tab/add_tab_usecase.dart';

@Injectable()
class TabController with ChangeNotifier {
  final AddTabUsecase addTabUsecase;

  TabController({required this.addTabUsecase});

  int _active = 0;

  int get active => _active;
  set active(int value) {
    _active = value;
    notifyListeners();
  }

  Future<void> addNewTab() async {
    //TODO define [AddTabUsecase] call

    notifyListeners();
  }
}
