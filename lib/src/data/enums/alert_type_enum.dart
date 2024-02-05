// DEPRECATED. Converted to freezed object.
// /// Available alert types for sensor alert system.
// enum AlertType {
//   /// Used for notification purposes,
//   /// e.g. low temperature increase.
//   info,

//   /// Used for purposes where attention needs to be focused,
//   /// e.g. temperature jump higher than normal.
//   warning,

//   /// Used for errors in sensors,
//   /// e.g. unexpected sensor value jumps.
//   error,

//   /// Used for purposes when something fails, etc.,
//   /// e.g. sensor connections breakdown.
//   fatal,
// }

/// Available alert types for alert system.
class AlertType with _$AlertType {
  /// Used when ???
  const factory AlertType.info() = _InfoAlertType;

  /// 
  const factory AlertType.warning() = _InfoAlertType;

  /// 
  const factory AlertType.error() = _InfoAlertType;

  /// 
  const factory AlertType.fatal() = _FatalAlertType;
}
