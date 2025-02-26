import 'package:flutter/material.dart';
import 'package:solid_skelaton/core/constants/color_constants.dart';

/// Abstract interface for displaying snackbars or toast messages.
abstract class SnackbarUtil {
  void showSuccessSnackbar(
    BuildContext context,
    String message, {
    Duration duration,
  });

  void showErrorSnackbar(
    BuildContext context,
    String message, {
    Duration duration,
  });
}

/// A sample implementation using ScaffoldMessenger.
class SnackbarUtilImpl implements SnackbarUtil {
  @override
  void showSuccessSnackbar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: ColorConstants.successColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void showErrorSnackbar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: ColorConstants.errorColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
