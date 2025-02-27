import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/widgets/base_bloc_consumer.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../auth/presentation/bloc_or_provider/auth_bloc.dart';
import '../../../auth/presentation/bloc_or_provider/auth_event.dart'
    show LogoutRequested;
import '../../../auth/presentation/bloc_or_provider/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRoutes.login);
        }
      },
      builder: (_, __) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            const SizedBox(height: 10),
            _buildLogoutBtn(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn() {
    return ElevatedButton(
      onPressed: () {
        log("Hello world");
        try {
          context.read<AuthBloc>().add(LogoutRequested());
        } catch (e) {
          log('$e');
        }
      },
      child: const Text("Log out"),
    );
  }
}
