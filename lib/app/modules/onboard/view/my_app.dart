import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/route_name.dart';
import '../../../utils/localization/app_localization.dart';
// import '../../../utils/manager/local_notification_manager.dart';
import '../../../utils/manager/navigation_manager.dart';
// import '../../../utils/services/app_state.dart';
import '../../../utils/services/custom_theme.dart';
import '../../../utils/services/util_methods.dart';

// @pragma('vm:entry-point')
// Future<void> _onBackgroundMessage(RemoteMessage message) async {
//   /// trigger firebase background event here
// }

final class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final class _MyAppState extends State<MyApp> {
  final botToastBuilder = BotToastInit();
  String newMessageId = '';

  @override
  void initState() {
    // _initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UtilMethods.instance.setOrientation();
    return MaterialApp(
      title: 'Base Setup',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: CustomTheme.lightTheme(),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: NavigationManager.onGenerateRoute,
      navigatorKey: NavigationManager.navigatorKey,
      locale: Locale(AppConstants.localeEn),
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: botToastBuilder(context, child),
          ),
      navigatorObservers: [BotToastNavigatorObserver()],
      supportedLocales: const [
        Locale(AppConstants.localeEn, ''),
        Locale(AppConstants.localeAr, ''),
      ],
      localizationsDelegates: const [AppLocalizations.delegate],
    );
  }

  // Future<void> _initializeFirebase() async {
  //   FirebaseMessaging.instance.getInitialMessage().then((message) async {
  //     if (message == null) return;
  //     await appState.appInitializationCompleter.future;
  //     if (!LocalNotificationManager.isInitialized) {
  //       if (mounted) LocalNotificationManager.initialize(context);
  //     }
  //     if (mounted) LocalNotificationManager.navigate(context, message.data);
  //   });
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.messageId != newMessageId) {
  //       if (!LocalNotificationManager.isInitialized) {
  //         LocalNotificationManager.initialize(
  //           NavigationManager.navigatorKey.currentContext!,
  //         );
  //       }
  //       LocalNotificationManager.displayMessage(message);
  //       newMessageId = message.messageId!;
  //     }
  //   });
  //   FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     if (!LocalNotificationManager.isInitialized) {
  //       LocalNotificationManager.initialize(
  //         NavigationManager.navigatorKey.currentContext!,
  //       );
  //     }
  //     LocalNotificationManager.navigate(
  //       NavigationManager.navigatorKey.currentContext!,
  //       message.data,
  //     );
  //   });
  // }
}
