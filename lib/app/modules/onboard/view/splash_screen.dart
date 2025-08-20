import 'dart:async';

import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';
import 'package:timoraa/app/utils/manager/api_controller.dart';
import 'package:timoraa/app/utils/manager/get_it_manager.dart';

import '../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/manager/storage_manager.dart';
import '../../../utils/services/app_state.dart';
import '../../../utils/services/package_services.dart';
import '../../../utils/services/value_checker.dart';

final class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashScreen> {
  final ValueNotifier<bool> onBoard = ValueNotifier<bool>(false);

  @override
  void initState() {
    _setInitialValues(context);
    ValueChecker().getUserLocationInfo().then((code) {
      appState.countryCode.value = code.countryCode;
      appState.ipAddress.value = code.ipAddress;
      Timer(Duration(seconds: 3), () {
        onBoard.value = true;
      });
    });
    super.initState();
  }

  void _setInitialValues(BuildContext context) async {
    await Future.wait([
      getIt<StorageManager>().init(),
      getIt<PackageServices>().getDeviceInfo(),
      appState.setInitialValues(),
    ]);
    final userId =
        await getIt<StorageManager>().getIntData(AppConstants.userId) ?? 0;
    final userName =
        await getIt<StorageManager>().getData(AppConstants.name) ?? '';
    final sessionId =
        await getIt<StorageManager>().getData(AppConstants.sessionId) ?? '';
    final userImage =
        await getIt<StorageManager>().getData(AppConstants.userImage) ?? '';
    getIt<APIController>().prepareRequest();
    APIController();
    if (userId != 0 && sessionId.isNotEmpty && userName.isNotEmpty) {
      appState.setUserId = "$userId";
      appState.setUserName = userName;
      appState.setSessionId = sessionId;
      appState.setUserImage = userImage;
    }
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: Stack(
        children: [
          Image.asset(
            AssetConstants.icSplashScreen,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ValueListenableBuilder(
            valueListenable: onBoard,
            builder: (context, value, child) {
              return value
                  ? Column(
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
                            context.pushReplacementNamed(
                              RouteName.dashboardScreen,
                            );
                          },
                        ),
                      ),
                      const Gap(50),
                    ],
                  )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
