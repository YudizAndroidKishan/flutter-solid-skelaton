// lib/core/utils/error_route_mapper.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:solid_skelaton/core/api/api_exceptions.dart';
import 'package:solid_skelaton/core/di/di.dart';
import 'package:solid_skelaton/core/navigation/app_routes.dart';
import 'package:solid_skelaton/core/utils/snackbar_utils.dart';

/// This method uses a mapping between exception types and route names to determine
/// the route to navigate to. It returns a command that can be used with the
/// [GoRouter] to navigate to the route.
///
/// The mapping is as follows:
///
/// * [ServerMaintenanceException]: [AppRoutes.serverMaintenance]
/// * [PaymentPendingException]: [AppRoutes.paymentPending]
/// * [SessionExpired]: [AppRoutes.login]
///
/// If the error is null, or if it is not one of the above types, this method
/// returns null.
final Map<Type, String> errorRouteMapping = {
  ServerMaintenanceException: AppRoutes.serverMaintenance,
  PaymentPendingException: AppRoutes.paymentPending,
  SessionExpired: AppRoutes.login,
};

/// Returns a route name for the given error. The mapping from error types to
/// route names is as follows:
///
/// * [ServerMaintenanceException]: [AppRoutes.serverMaintenance]
/// * [PaymentPendingException]: [AppRoutes.paymentPending]
/// * [SessionExpired]: [AppRoutes.login]
///
/// If the error is null, or if it is not one of the above types, this method
/// returns null.
String? getRouteForError(dynamic error, BuildContext context) {
  log(error.runtimeType.toString(), name: 'getRouteForError');
  if (error == null) return null;
  if (error is ServerMaintenanceException) {
    return errorRouteMapping[ServerMaintenanceException];
  } else if (error is PaymentPendingException) {
    return errorRouteMapping[PaymentPendingException];
  } else if (error is SessionExpired) {
    getIt<SnackbarUtil>().showErrorSnackbar(
      context,
      error.toString(),
    );
    return errorRouteMapping[SessionExpired];
  }
  return null;
}
