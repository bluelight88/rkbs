import 'dart:async';

import 'package:base_project/app/utils/constants/asset_constants.dart';
import 'package:base_project/app/utils/constants/color_constants.dart';
import 'package:base_project/app/utils/constants/route_name.dart';
import 'package:base_project/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      context.pushReplacementNamed(RouteName.authScreen);
    });
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Image.asset(
        AssetConstants.splashScreen,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
