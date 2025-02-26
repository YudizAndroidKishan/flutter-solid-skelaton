import 'package:solid_skelaton/core/api/api_exceptions.dart';

mixin ErrorMessageMixin {
  /// Extracts a user-friendly error message from the given [error].
  dynamic extractErrorMessage(dynamic error) {
    if (error is DescriptiveError) {
      return error.toString();
    }
  }
}
