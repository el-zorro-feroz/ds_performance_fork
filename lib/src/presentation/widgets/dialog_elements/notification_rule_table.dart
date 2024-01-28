import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:sensors_monitoring/core/enum/rule_type.dart';
import 'package:sensors_monitoring/src/domain/entities/sensor_rule.dart';

class NotificationRuleTable extends StatelessWidget {
  final int index;
  final SensorRule sensorRule;
  final TextEditingController valueEditingController;
  final Function()? onDeleteCallback;
  final Function()? onEditingComplete;

  const NotificationRuleTable({
    super.key,
    required this.sensorRule,
    required this.index,
    required this.valueEditingController,
    this.onDeleteCallback,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final Typography typography = FluentTheme.of(context).typography;

    final Map<RuleType, String> ruleTypeToStrData = <RuleType, String>{
      RuleType.avg: "AVG changes Rule",
      RuleType.max: "Minimal val Rule",
      RuleType.min: "Maximum val Rule",
    };

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    ruleTypeToStrData[sensorRule.ruleType]!,
                    style: typography.body,
                  ),
                ),
                IconButton(
                  icon: const Icon(FluentIcons.delete),
                  onPressed: onDeleteCallback,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                // DEPRECATED
                //
                // TableRow(children: [
                //   Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Text(
                //       'State',
                //       style: typography.body,
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: Text(
                //       'Value',
                //       style: typography.body,
                //     ),
                //   ),
                // ]),
                TableRow(
                  children: [
                    Text(
                      'Value:',
                      style: typography.caption,
                    ),
                    TextBox(
                      controller: valueEditingController,
                      onEditingComplete: onEditingComplete,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                      maxLines: 1,
                      placeholder: '0.0',
                      placeholderStyle: typography.caption,
                      style: typography.caption,
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
