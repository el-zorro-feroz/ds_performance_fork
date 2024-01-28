import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';
import 'package:sensors_monitoring/src/presentation/widgets/dialog_elements/notification_rule_table.dart';
import 'package:uuid/uuid.dart';

class _SelectorController with ChangeNotifier {
  late AlertData resultAlertData;

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController messageEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();

  _SelectorController({
    required AlertData data,
  }) {
    resultAlertData = data;
    titleEditingController.text = data.title;
    messageEditingController.text = data.message;
    descriptionEditingController.text = data.description;
  }

  void changeResultTitle() {
    resultAlertData = resultAlertData.copyWith(
      title: titleEditingController.text,
    );
  }

  void changeResultMessage() {
    resultAlertData = resultAlertData.copyWith(
      message: messageEditingController.text,
    );
  }

  void changeResultDescription() {
    resultAlertData = resultAlertData.copyWith(
      description: descriptionEditingController.text,
    );
  }

  void changeResultType(AlertType type) {
    resultAlertData = resultAlertData.copyWith(
      type: type,
    );

    notifyListeners();
  }

  void addRule(RuleType type) {
    resultAlertData = resultAlertData.copyWith(
      sensorRuleList: List.from(
        resultAlertData.sensorRuleList,
      )..add(
          SensorRule(
            id: const Uuid().v4(),
            ruleType: type,
            value: 0.0,
          ),
        ),
    );

    notifyListeners();
  }

  void deleteRuleByIndex(int index) {
    resultAlertData.copyWith(
      sensorRuleList: List.from(
        resultAlertData.sensorRuleList,
      )..removeAt(index),
    );

    notifyListeners();
  }

  void changeRuleValueByIndex(int index, String value) {
    final double? obusValue = double.tryParse(value);
    if (obusValue != null) {
      resultAlertData.copyWith(
        sensorRuleList: List.from(
          resultAlertData.sensorRuleList,
        )
          ..removeAt(index)
          ..insert(
            index,
            resultAlertData.sensorRuleList[index].copyWith(
              value: obusValue,
            ),
          ),
      );
    } else {
      debugPrint('_SelectorController($hashCode): trying to set invalid sensor rule value');
    }
  }
}

Future<void> showSensorRuleSelectorDialog(
  BuildContext context, {
  required AlertData initialAlertData,
  Function(AlertData)? onCompleteEditing,
}) async {
  final _SelectorController controller = _SelectorController(data: initialAlertData);

  final Size size = MediaQuery.of(context).size;
  final Typography typography = FluentTheme.of(context).typography;

  final Map<AlertType, String> alertTypeToStrData = <AlertType, String>{
    AlertType.info: "Info",
    AlertType.error: "Error",
    AlertType.warning: "Warning",
    AlertType.fatal: "Fatal",
  };

  final Map<RuleType, String> ruleTypeToStrData = <RuleType, String>{
    RuleType.avg: "Average Sensor changes value check",
    RuleType.max: "Set Maximum Sensor value limit",
    RuleType.min: "Set Minimum Sensor value limit",
  };

  showDialog(
    context: context,
    builder: (_) => ContentDialog(
      actions: [
        Button(
          onPressed: () => GoRouter.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (onCompleteEditing != null) {
              onCompleteEditing(controller.resultAlertData);
            }
          },
          child: const Text('Accept'),
        ),
      ],
      content: ListenableBuilder(
        listenable: controller,
        builder: (_, __) {
          return SizedBox(
            width: 600,
            height: size.height,
            child: ScaffoldPage.scrollable(
              header: PageHeader(
                title: SizedBox(
                  width: double.infinity,
                  child: TextBox(
                    controller: controller.titleEditingController,
                    onEditingComplete: controller.changeResultTitle,
                    placeholder: 'Notification title',
                  ),
                ),
              ),
              children: [
                TextBox(
                  controller: controller.messageEditingController,
                  onEditingComplete: controller.changeResultMessage,
                  placeholder: 'Notification text',
                ),
                TextBox(
                  controller: controller.descriptionEditingController,
                  onEditingComplete: controller.changeResultDescription,
                  placeholder: 'Notification description',
                ),
                DropDownButton(
                  closeAfterClick: false,
                  buttonBuilder: (_, __) {
                    return Button(
                      onPressed: __,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        child: Wrap(
                          spacing: 8.0,
                          children: [
                            const Icon(
                              FluentIcons.chevron_down_med,
                            ),
                            Text(
                              alertTypeToStrData[controller.resultAlertData.type]!,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  items: AlertType.values.map<MenuFlyoutItem>((type) {
                    return MenuFlyoutItem(
                      text: Text(
                        alertTypeToStrData[type]!,
                      ),
                      onPressed: () => controller.changeResultType(type),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32.0,
                    bottom: 16.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Rules',
                          style: typography.subtitle,
                        ),
                      ),
                      // Replaced with dropdown menu above
                      //
                      // IconButton(
                      //   icon: const Icon(FluentIcons.add),
                      //   onPressed: controller.addRule,
                      // ),
                    ],
                  ),
                ),
                DropDownButton(
                  closeAfterClick: false,
                  buttonBuilder: (_, __) {
                    return Button(
                      onPressed: __,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ),
                        child: const Wrap(
                          spacing: 8.0,
                          children: [
                            Icon(
                              FluentIcons.chevron_down_med,
                            ),
                            Text(
                              'Select rule',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  items: RuleType.values.map<MenuFlyoutItem>((type) {
                    return MenuFlyoutItem(
                      text: Text(
                        ruleTypeToStrData[type]!,
                      ),
                      onPressed: () => controller.addRule(type),
                    );
                  }).toList(),
                ),
                // AutoSuggestBox(
                //   placeholder: 'Add Exists Rule',
                //   items: List.generate(
                //     5,
                //     (_) => AutoSuggestBoxItem(
                //       value: _,
                //       label: 'label $_',
                //     ),
                //   ),
                // ),
                ...List.generate(
                  controller.resultAlertData.sensorRuleList.length,
                  (index) {
                    SensorRule data = controller.resultAlertData.sensorRuleList.elementAt(index);
                    final TextEditingController valueTextEditingController = TextEditingController()..text = data.value.toString();

                    return NotificationRuleTable(
                      index: index,
                      sensorRule: data,
                      valueEditingController: valueTextEditingController,
                      onDeleteCallback: () => controller.deleteRuleByIndex(index),
                      onEditingComplete: () => controller.changeRuleValueByIndex(index, valueTextEditingController.text),
                    );
                  },
                ).reversed,
              ],
            ),
          );
        },
      ),
    ),
  );
}
