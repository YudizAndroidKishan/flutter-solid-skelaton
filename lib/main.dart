import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart' show MyApp;
import 'core/bloc/app_bloc_observer.dart';
import 'core/di/di.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  await setupDependencies();

  runApp(MyApp());
}
