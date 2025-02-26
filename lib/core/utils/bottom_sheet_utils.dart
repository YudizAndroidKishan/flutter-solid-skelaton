import 'package:flutter/material.dart';

class BottomSheetUtils {
  /// Opens a modal bottom sheet with the given [child] widget.
  static Future<T?> openBottomSheet<T>(
    BuildContext context,
    Widget child, {
    bool isDismissible = true,
    bool enableDrag = true,
    double elevation = 0.0,
    Color backgroundColor = Colors.white,
    bool isScrollControlled = true,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      elevation: elevation,
      backgroundColor: backgroundColor,
      isScrollControlled: isScrollControlled,
      builder: (BuildContext context) => child,
    );
  }
}
