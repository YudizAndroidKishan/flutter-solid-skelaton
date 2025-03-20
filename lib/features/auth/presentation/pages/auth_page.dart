import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solid_skelaton/core/navigation/app_routes.dart';

import '../../../../app/widgets/base_bloc_consumer.dart';
import '../bloc_or_provider/auth_bloc.dart';
import '../bloc_or_provider/auth_event.dart';
import '../bloc_or_provider/auth_state.dart';
import '../widgets/login_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Page')),
      body: BaseBlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppRoutes.leaveListing);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, ${state.user.name}!'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          } else {
            // Show login form
            return const LoginForm();
          }
        },
      ),
    );
  }
}
