import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/constants/asset_constants.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/route_name.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            AssetConstants.icSplashScreen,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.99,
            fit: BoxFit.fitHeight,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Center(
                  child: Text(
                    "Find the perfect stylist at your door Steps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 23,
                      fontFamily: "PlusJakartaSans",
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppElevatedButton(
                  Text(
                    "Get Started",
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontSize: 17,
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: ColorConstants.whiteColor,
                  onPressed: () {
                    context.pushReplacementNamed(RouteName.dashboardScreen);
                  },
                ),
              ),
              const Gap(50),
            ],
          ),
        ],
      ),
    );
  }
}
