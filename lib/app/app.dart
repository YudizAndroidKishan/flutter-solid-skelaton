import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/navigation/go_router_service.dart';
import '../core/navigation/router_service.dart';
import 'theme.dart';
import 'widgets/app_bloc_provider.dart';

class MyApp extends StatelessWidget {
  final RouterService routerService = GoRouterService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProviders(
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: appTheme,
        routerDelegate: routerService.routerDelegate,
        routeInformationParser: routerService.routeInformationParser,
        routeInformationProvider: routerService.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
