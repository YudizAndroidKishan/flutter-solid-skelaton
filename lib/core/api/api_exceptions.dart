/// Thrown when the server is currently under maintenance.
///
/// This exception is used to trigger navigation to a [ServerMaintenanceScreen].
class ServerMaintenanceException implements Exception {
  final String message;

  ServerMaintenanceException(
      [this.message = "Server under maintenance. Please try again later."]);

  @override
  String toString() => message;
}

/// Thrown when a payment is pending.
///
/// This exception is used to trigger navigation to a [PaymentPendingScreen].
class PaymentPendingException implements Exception {
  final String message;

  PaymentPendingException(
      [this.message = "Payment pending. Please contact support."]);

  @override
  String toString() => message;
}

/// Thrown when an unexpected error occurs that is not otherwise handled by
/// the above exceptions.
class DescriptiveError implements Exception {
  final String message;

  DescriptiveError([this.message = "Something went wrong..."]);

  @override
  String toString() => message;
}

/// Thrown when a session has expired.
class SessionExpired implements Exception {
  final String message;

  SessionExpired([this.message = "Session Expired"]);

  @override
  String toString() => message;
}
