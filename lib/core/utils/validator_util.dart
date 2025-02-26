/// Abstract interface for validation utilities.
abstract class ValidatorUtil {
  /// Returns true if the email is valid.
  bool validateEmail(String email);

  /// Returns true if the username is valid.
  bool validateUserName(String userName);

  /// Returns true if the phone number is valid.
  bool validatePhone(String phone);

  /// Returns true if the password meets the criteria.
  bool validatePassword(String password);
}

/// A sample implementation of validation rules.
class ValidatorUtilImpl implements ValidatorUtil {
  @override
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  bool validateUserName(String userName) {
    return userName.isNotEmpty;
  }

  @override
  bool validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\+?\d{7,15}$');
    return phoneRegex.hasMatch(phone);
  }

  @override
  bool validatePassword(String password) {
    // Example: Password must be at least 6 characters.
    return password.length >= 6;
  }
}
