import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/modules/auth/view_model/splash_init/splash_init_bloc.dart';
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

final class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  final ValueNotifier<bool> onBoard = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 1.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    ValueChecker().getUserLocationInfo().then((code) {
      appState.countryCode.value = code.countryCode;
      appState.ipAddress.value = code.ipAddress;
      if (mounted) {
        context.read<SplashInitBloc>().add(UserSplashInit());
      }
      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;
        if (appState.userId.isEmpty) {
          onBoard.value = true;
          // Restart animation for the onboarding content
          _controller.reset();
          _controller.forward();
        } else {
          context.pushReplacementNamed(RouteName.dashboardScreen);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    onBoard.dispose();
    super.dispose();
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
      appState.loginUserName.value = userName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: BlocListener<SplashInitBloc, SplashInitState>(
        listener: (context, state) {
          if (state is SplashInitSuccess) {
            _setInitialValues(context);
          }
        },
        child: Stack(
          children: [
            // Background Image with Scale Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  );
                },
                child: Image.asset(
                  AssetConstants.icSplashScreen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Gradient Overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.8),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),

            // Onboarding Content
            ValueListenableBuilder(
              valueListenable: onBoard,
              builder: (context, value, child) {
                if (!value) return const SizedBox.shrink();
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Center(
                            child: Text(
                              "Find the perfect stylist\nat your door Steps",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                                letterSpacing: 0.5,
                                fontFamily: AssetConstants.fontPlusJakartaSans,
                                color: ColorConstants.whiteColor,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const Gap(30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AppElevatedButton(
                            Text(
                              "Get Started",
                              style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontSize: 18,
                                fontFamily: AssetConstants.fontPlusJakartaSans,
                                fontWeight: FontWeight.bold,
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
                        const Gap(60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
