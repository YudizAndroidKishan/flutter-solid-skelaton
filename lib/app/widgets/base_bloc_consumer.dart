import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solid_skelaton/core/api/api_exceptions.dart';
import 'package:solid_skelaton/core/errors/error_state.dart';

import '../../core/di/di.dart';
import '../../core/errors/error_message_mixin.dart';
import '../../core/errors/error_route_mapper.dart';
import '../../core/utils/snackbar_utils.dart';

/// A custom BlocConsumer widget that automatically handles global error
/// navigation for server maintenance and payment pending errors
/// and also handels custom error messages form api.
class BaseBlocConsumer<B extends BlocBase<S>, S> extends StatelessWidget
    with ErrorMessageMixin {
  /// The builder callback for your UI.
  final BlocWidgetBuilder<S> builder;

  /// An optional listener callback for additional logic.
  final BlocWidgetListener<S>? listener;

  final SnackbarUtil snackbarUtil = getIt<SnackbarUtil>();

  BaseBlocConsumer({
    super.key,
    required this.builder,
    this.listener,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      listener: (context, state) {
        if (state is ErrorState) {
          final route = getRouteForError(state.message);
          if (route != null) {
            context.go(route);
            return;
          } else {
            if (state.message is DescriptiveError) {
              snackbarUtil.showErrorSnackbar(
                context,
                state.message.toString(),
              );
            }
          }
        }

        if (listener != null) {
          listener!(context, state);
        }
      },
      builder: builder,
    );
  }
}
