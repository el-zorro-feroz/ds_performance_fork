import 'package:fluent_ui/fluent_ui.dart';
import 'package:sensors_monitoring/core/enum/alert_type.dart';
import 'package:sensors_monitoring/core/enum/sensor_type.dart';
import 'package:sensors_monitoring/core/services/services.dart';
import 'package:sensors_monitoring/src/domain/entities/alert_data.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_info.dart';
import 'package:sensors_monitoring/src/presentation/controllers/config_settings_controller.dart';

class ConfigSettingsPage extends StatelessWidget {
  final String? configId;

  const ConfigSettingsPage({
    super.key,
    this.configId,
  });

  @override
  Widget build(BuildContext context) {
    final ConfigSettingsController controller = services<ConfigSettingsController>();

    controller.initConfig(configId);

    final Typography typography = FluentTheme.of(context).typography;

    // Future<void> addAlertRule(BuildContext context) async {
    //   showSensorRuleSelectorDialog(context);
    // }

    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        if (controller.configId == null) {
          return const Center(child: ProgressRing());
        }
        final focusNode = FocusNode();
        final sensorTitleFocusNode = FocusNode();
        final sensorDetailsFocusNode = FocusNode();
        return ScaffoldPage.scrollable(
          header: PageHeader(
            title: Text(
              // controller.config.title,
              (controller.config.title.isEmpty) ? 'New configuration' : controller.config.title,
              style: typography.title,
            ),
            commandBar: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   icon: const Icon(
                //     FluentIcons.remove_content,
                //   ),
                //   onPressed: () => controller.onRemoveConfigurationPressed(context),
                // ),
                // const SizedBox(width: 2.0),
                IconButton(
                  icon: const Icon(
                    FluentIcons.accept,
                  ),
                  onPressed: () => controller.onSaveConfigurationPressed(context),
                ),
              ],
            ),
          ),
          bottomBar: Padding(
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(),
                ),
                Button(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      children: [
                        const Icon(
                          FluentIcons.delete,
                        ),
                        Text(
                          'Remove Configuration',
                          style: typography.body,
                        ),
                      ],
                    ),
                  ),
                  onPressed: () => controller.onRemoveConfigurationPressed(context),
                ),
              ],
            ),
          ),
          children: [
            TextBox(
              placeholder: controller.config.title,
              controller: controller.titleEditingController,
              onEditingComplete: () {
                focusNode.unfocus();
                controller.ontitleEditingComplete();
              },
              focusNode: focusNode,
              onTapOutside: (event) {
                focusNode.unfocus();
                controller.ontitleEditingComplete();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            Visibility(
              visible: controller.config.sensorList.isEmpty,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text('Empty list'),
              ),
            ),
            Visibility(
              visible: controller.config.sensorList.isNotEmpty,
              child: Column(
                children: List.generate(
                  controller.config.sensorList.length,
                  (sensorIndex) {
                    final SensorInfo sensorInfo = controller.config.sensorList.elementAt(sensorIndex);

                    return Expander(
                      trailing: Row(
                        children: [
                          IconButton(
                            icon: const Icon(FluentIcons.delete),
                            onPressed: () => controller.deleteSensorByID(context, sensorIndex),
                          ),
                        ],
                      ),
                      header: TextBox(
                        controller: controller.getSensorTitleControllerByIndex(sensorIndex: sensorIndex),
                        focusNode: sensorTitleFocusNode,
                        placeholder: sensorInfo.title.isEmpty ? 'Sensor Title' : sensorInfo.title,
                        onEditingComplete: () {
                          sensorTitleFocusNode.unfocus();
                          controller.changeSensorTitleByIndex(sensorIndex: sensorIndex);
                        },
                        onTapOutside: (event) {
                          sensorTitleFocusNode.unfocus();
                          controller.changeSensorTitleByIndex(sensorIndex: sensorIndex);
                        },
                      ),
                      content: Wrap(
                        runSpacing: 8.0,
                        children: [
                          TextBox(
                            controller: controller.getSensorDetailsControllerByIndex(sensorIndex: sensorIndex),
                            focusNode: sensorDetailsFocusNode,
                            placeholder: sensorInfo.details.isEmpty ? 'Sensor details' : sensorInfo.details,
                            onEditingComplete: () {
                              sensorDetailsFocusNode.unfocus();
                              controller.changeSensorDetailsByIndex(sensorIndex: sensorIndex);
                            },
                            onTapOutside: (event) {
                              sensorDetailsFocusNode.unfocus();
                              controller.changeSensorDetailsByIndex(sensorIndex: sensorIndex);
                            },
                          ),
                          DropDownButton(
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
                                        'Select sensor type',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            // items: <MenuFlyoutItemBase>[
                            //   MenuFlyoutItem(text: const Text('Type 1'), onPressed: () => null),
                            //   MenuFlyoutItem(text: const Text('Type 2'), onPressed: () => null),
                            //   MenuFlyoutItem(text: const Text('Type 3'), onPressed: () => null),
                            //   MenuFlyoutItem(text: const Text('Type 4'), onPressed: () => null),
                            // ],
                            items: SensorType.values.map<MenuFlyoutItem>((type) {
                              return MenuFlyoutItem(
                                text: Text(
                                  <SensorType, String>{SensorType.humidity: "Humidity", SensorType.temperature: "Temperature"}[type] ?? "Invalid",
                                ),
                                onPressed: () => controller.changeSensorTypeByID(context, sensorIndex, type),
                              );
                            }).toList(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...List.generate(
                                sensorInfo.alerts.length,
                                (alertIndex) => SensorAlertSetting(
                                  alert: sensorInfo.alerts.elementAt(alertIndex),
                                  onEditAlertPressed: () => controller.editAlertByIndex(context, alertIndex, sensorIndex),
                                  onDeleteAlertPressed: () => controller.deleteAlertByIndex(context, alertIndex, sensorIndex),
                                ),
                              ),
                              Button(
                                onPressed: () => controller.addAlert(context, sensorIndex),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(4.0),
                                  child: const Text(
                                    'Add notification',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Button(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  children: [
                    const Icon(
                      FluentIcons.add,
                    ),
                    Text(
                      'Add Sensor',
                      style: typography.body,
                    ),
                  ],
                ),
              ),
              onPressed: controller.addSensor,
            ),
          ],
        );
      },
    );
  }
}

class SensorAlertSetting extends StatelessWidget {
  final AlertData alert;
  final Function()? onEditAlertPressed;
  final Function()? onDeleteAlertPressed;

  const SensorAlertSetting({
    super.key,
    required this.alert,
    this.onEditAlertPressed,
    this.onDeleteAlertPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    final SensorAlertSettingData settingData = SensorAlertSettingData.getSettingData(alert.type);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(32.0),
          ),
          color: settingData.lableColor,
        ),
        child: Text(
          settingData.lable,
          style: typography.caption,
        ),
      ),
      title: Text(
        alert.description,
        style: typography.caption,
      ),
      subtitle: Text(
        '${alert.sensorRuleList.length} rules active',
        style: typography.caption,
      ),
      trailing: Row(
        children: [
          IconButton(
            icon: const Icon(FluentIcons.edit),
            onPressed: onEditAlertPressed,
          ),
          IconButton(
            icon: const Icon(FluentIcons.delete),
            onPressed: onDeleteAlertPressed,
          ),
        ],
      ),
    );
  }
}

class SensorAlertSettingData {
  final String lable;
  final Color lableColor;

  const SensorAlertSettingData({
    required this.lable,
    required this.lableColor,
  });

  static SensorAlertSettingData getSettingData(AlertType type) {
    try {
      return {
        AlertType.info: const SensorAlertSettingData(lable: 'Information', lableColor: Color(0xFF8787FF)),
        AlertType.warning: const SensorAlertSettingData(lable: 'Warning', lableColor: Color(0xFFFFAA22)),
        AlertType.error: const SensorAlertSettingData(lable: 'Error', lableColor: Color(0xFFFF2222)),
        AlertType.fatal: const SensorAlertSettingData(lable: 'Fatal Error', lableColor: Color(0xFFFF2222)),
      }[type]!;
    } catch (_) {
      throw Exception('Called unsupported [AlertType]');
    }
  }
}
