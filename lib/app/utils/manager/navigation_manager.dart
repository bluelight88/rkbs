import 'package:timoraa/app/modules/dashboard/view/dashboard_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/modules/provider_detail/view/package/package_view.dart';
import 'package:timoraa/app/modules/provider_detail/view/provider_detail_screen.dart';
import 'package:timoraa/app/modules/provider_detail/view_model/provider_detail/provider_detail_bloc.dart';
import '../../modules/auth/view/login/login_screen.dart';
import '../../modules/auth/view_model/login/login_bloc.dart';
import '../../modules/auth/view_model/splash_init/splash_init_bloc.dart';
import '../../modules/booking/view/appointment_confirm/appointment_confirmed_screen.dart';
import '../../modules/booking/view/booking_selection/booking_screen.dart';
import '../../modules/booking/view/review_booking/review_booking_screen.dart';
import '../../modules/booking/view_model/booking_service_bloc.dart';
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
      RouteName.appointmentConfirmed => AppointmentConfirmedScreen(),
      RouteName.authScreen => MultiBlocProvider(
        providers: [BlocProvider(create: (context) => LoginBloc())],
        child: LoginScreen(fromBooking: args['fromBooking'] ?? false),
      ),
      RouteName.bookingScreen => BlocProvider(
        create: (context) => BookingServiceBloc(),
        child: BookAppointmentScreen(services: args["services"]),
      ),
      RouteName.dashboardScreen => const DashboardScreen(),
      RouteName.onBoardingScreen => const OnBoardingScreen(),
      RouteName.packageViewScreen => const PackageViewScreen(),
      RouteName.providerDetailScreen => BlocProvider(
        create: (context) => ProviderDetailBloc(),
        child: ProviderDetailScreen(
          providerId: args["providerId"],
          title: args["title"],
        ),
      ),
      RouteName.splashScreen => BlocProvider(
        create: (context) => SplashInitBloc(),
        child: SplashScreen(),
      ),
      RouteName.reviewBookingScreen => BlocProvider(
        create: (context) => BookingServiceBloc(),
        child: ReviewBookingScreen(),
      ),
      _ => UnderDevelopmentScreen(showLeading: args['showLeading'] ?? true),
    };
    return routeScreen;
  }
}
