import 'dart:async' show runZonedGuarded;
import 'dart:io'
    show HttpClient, HttpOverrides, SecurityContext, X509Certificate;

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart'
    show WidgetsFlutterBinding, runApp;
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/services/util_methods.dart';

// import 'package:firebase_core/firebase_core.dart';

import 'app/modules/onboard/view/my_app.dart';
import 'app/utils/constants/app_config.dart';
import 'app/utils/extensions/bloc_observer_extension.dart';
import 'app/utils/manager/get_it_manager.dart';

void main() {
  /// DO NOT Change Environment without approval
  AppConfig.instance.setEnvironment(Environment.prod);
  mainDelegate();
}

void mainDelegate() async {
  runZonedGuarded<void>(() async {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    UtilMethods().changeSystemColor(ColorConstants.primaryColor);

    /// uncomment once integrated firebase
    // await Firebase.initializeApp();
    await initializeGetItDependencies();
    if (!AppConfig.instance.isFlavourInitialized) {
      AppConfig.instance.setEnvironment(AppConfig.instance.currentEnv);
    }
    if (kDebugMode) Bloc.observer = BlocObserverExtension();
    runApp(const MyApp());
  }, (error, stack) {});
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
}
