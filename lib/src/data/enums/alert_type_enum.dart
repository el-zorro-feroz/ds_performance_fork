/// Available alert types for sensor alert system.
enum AlertTypeEnum {
  /// Used for notification purposes,
  /// e.g. low temperature increase.
  info,

  /// Used for purposes where attention needs to be focused,
  /// e.g. temperature jump higher than normal.
  warning,

  /// Used for errors in sensors,
  /// e.g. unexpected sensor value jumps.
  error,

  /// Used for purposes when something fails, etc.,
  /// e.g. sensor connections breakdown.
  fatal,
}
