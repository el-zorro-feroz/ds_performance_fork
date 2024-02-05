/// TODO(freezed): convert [RuleType] to freezed object

/// Available rule types for alert system.
enum RuleType {
  /// Used to set up minimum value limits for rules.
  minimum,

  /// Used to set up maximum value limits for rules.
  maximum,

  /// Used to set the maximum difference in values over time for a rule.
  average,
}
