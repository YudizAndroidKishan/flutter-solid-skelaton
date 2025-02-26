/// This state is used to represent an error that occurred while performing
/// an operation in the app. The error message is provided by the
/// [message] property.
abstract class ErrorState {
  dynamic get message;
}
