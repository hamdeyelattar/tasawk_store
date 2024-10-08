import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawk/src/app.dart';
import 'package:tasawk/src/core/app/bloc_observer.dart';
import 'package:tasawk/src/core/app/env_variables.dart';
import 'package:tasawk/src/core/service/shared_pref/shared_pref.dart';
import 'package:tasawk/src/injector.dart';

void main() async {
  await EnvVariable.instance.init(envTybe: EnvTybe.dev);
  Bloc.observer = AppBlocObserver();
  await SHP().instantiatePreferences();
  await init();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    runApp(const Tasawk());
  });
}
