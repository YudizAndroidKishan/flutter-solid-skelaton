import 'dart:developer';

import 'package:flutter/material.dart';

class NavigationLogger extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
      'Navigating to ${route.settings.name}',
      name: "Navigation Logger",
    );
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log(
      'Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
      name: "Navigation Logger",
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(
      'Popped ${route.settings.name}, returning to ${previousRoute?.settings.name}',
      name: "Navigation Logger",
    );
    super.didPop(route, previousRoute);
  }
}
