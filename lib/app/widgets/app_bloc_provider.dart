import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_skelaton/features/leave_listing/presentation/bloc/leave_listing_bloc.dart';

import '../../core/di/di.dart';
import '../../features/auth/presentation/bloc_or_provider/auth_bloc.dart';
import '../../features/home/presentation/bloc_or_provider/home_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => getIt<HomeCubit>(),
        ),
        BlocProvider<LeaveListingBloc>(
          create: (context) => getIt<LeaveListingBloc>(),
        ),
        // Add additional BlocProviders here as needed.
      ],
      child: child,
    );
  }
}
