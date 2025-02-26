import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/di.dart';
import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';

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
    // Retrieve the GetCurrentUserUseCase from your DI container.
    final getCurrentUserUseCase = getIt<GetCurrentUserUseCase>();

    // Attempt to retrieve the current user.
    final User? user = await getCurrentUserUseCase();

    // Optional: Add a delay to show the splash screen for a minimum duration.
    await Future.delayed(const Duration(seconds: 2));

    // Check if the widget is still mounted before using the context.
    if (!mounted) return;

    // Redirect based on whether the user exists.
    if (user != null) {
      // If a user is found, navigate to the home screen.
      context.go('/home');
    } else {
      // Otherwise, navigate to the login screen.
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
