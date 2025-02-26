import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solid_skelaton/features/auth/presentation/pages/auth_page.dart';
import 'package:solid_skelaton/features/home/presentation/pages/home_page.dart';

import '../../app/pages/app_spash_page.dart';
import 'app_routes.dart';
import 'navigation_logger.dart';
import 'router_service.dart';

class GoRouterService implements RouterService {
  late final GoRouter _router;

  GoRouterService() {
    _router = GoRouter(
      initialLocation: AppRoutes.splash,
      observers: [
        NavigationLogger(),
      ],
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.paymentPending,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.serverMaintenance,
          builder: (context, state) => const HomePage(),
        ),
      ],
    );
  }

  @override
  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;

  @override
  RouteInformationParser<Object> get routeInformationParser =>
      _router.routeInformationParser;

  @override
  RouteInformationProvider? get routeInformationProvider =>
      _router.routeInformationProvider;
}
