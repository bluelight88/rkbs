import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/auth/view/login/login_screen.dart';
import '../../modules/auth/view_model/login/login_bloc.dart';
import '../../modules/onboard/view/on_boarding_screen.dart';
import '../../modules/onboard/view/splash_screen.dart';
import '../../modules/onboard/view/under_development_screen.dart';
import '../constants/route_name.dart';

final class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> pipViewKey =
      GlobalKey<NavigatorState>();
  static BuildContext? dashboardContext;

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    Map<String, dynamic>? args =
        routeSettings.arguments as Map<String, dynamic>?;
    return MaterialPageRoute(
      builder:
          (context) => getRouteScreen(
            routeName: routeSettings.name ?? "",
            args: args ?? {},
          ),
    );
  }

  static Widget getRouteScreen({
    required final String routeName,
    final Map<String, dynamic> args = const {},
  }) {
    Widget routeScreen = const UnderDevelopmentScreen();
    routeScreen = switch (routeName) {
      // ************** OnBoard module starts **************
      RouteName.splashScreen => const SplashScreen(),
      // ************** OnBoard module ends **************
      // ************** Authentication module starts **************
      RouteName.authScreen => MultiBlocProvider(
        providers: [BlocProvider(create: (context) => LoginBloc())],
        child: const LoginScreen(),
      ),
      RouteName.onBoardingScreen => const OnBoardingScreen(),
      // ************** Authentication module ends **************
      _ => UnderDevelopmentScreen(showLeading: args['showLeading'] ?? true),
    };
    return routeScreen;
  }
}
