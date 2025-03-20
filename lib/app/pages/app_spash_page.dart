import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solid_skelaton/app/widgets/app_loading.dart';
import 'package:solid_skelaton/core/database/local_database.dart';
import 'package:solid_skelaton/core/navigation/app_routes.dart';

import '../../core/di/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectUser();
  }

  Future<void> _redirectUser() async {
    String? token = getIt<LocalDatabase>().getToken();

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Redirect based on whether the user exists.
    if (token != null) {
      // If a user is found, navigate to the home screen.
      context.go(AppRoutes.leaveListing);
    } else {
      // Otherwise, navigate to the login screen.
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLoadingWidget(),
      ),
    );
  }
}
