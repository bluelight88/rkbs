import 'dart:async';

import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:timoraa/app/utils/manager/api_controller.dart';
import 'package:timoraa/app/utils/manager/get_it_manager.dart';

import '../../../utils/services/app_state.dart';
import '../../../utils/services/value_checker.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getIt<APIController>().prepareRequest();
    APIController();
    ValueChecker().getUserLocationInfo().then((code) {
      appState.countryCode.value = code.countryCode;
      appState.ipAddress.value = code.ipAddress;
      Timer(Duration(seconds: 3), () {
        context.pushReplacementNamed(RouteName.onBoardingScreen);
      });
    });
    super.initState();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Image.asset(
        AssetConstants.icSplashScreen,
        fit: BoxFit.fill,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
