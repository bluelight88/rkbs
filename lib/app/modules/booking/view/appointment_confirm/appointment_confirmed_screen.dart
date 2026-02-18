import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';

import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../utils/constants/route_name.dart';
import '../../../../utils/services/app_state.dart';

class AppointmentConfirmedScreen extends StatefulWidget {
  const AppointmentConfirmedScreen({super.key});

  @override
  State<AppointmentConfirmedScreen> createState() =>
      _AppointmentConfirmedScreenState();
}

class _AppointmentConfirmedScreenState
    extends State<AppointmentConfirmedScreen> {
  ValueNotifier<bool> notificationGranted = ValueNotifier<bool>(false);

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.notification.status;
    notificationGranted.value = status.isGranted;
  }

  void _goToDashboard() {
    appState.cartItems.clear();
    appState.selectedTimeSlot.value = '';
    appState.selectedSlotInfo.value = '';
    appState.selectedSaloon.value = '';
    appState.selectedSaloonAddress.value = '';
    appState.totalPrice.value = 0.0;
    appState.appPageIndex.value = 2;
    context.pushNamedAndRemoveUntil(RouteName.dashboardScreen);
  }

  String _getTrimmedSlotInfo(String slotInfo) {
    final parts = slotInfo.split(' - ');
    if (parts.length > 2) {
      return '${parts[0]} - ${parts[1]}';
    }
    return slotInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(), // pushes content to vertical center
            const Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.check,
                    color: ColorConstants.whiteColor,
                    size: 25,
                  ),
                ),
              ),
            ),
            const Gap(20),
            const Text(
              "Appointment Confirmed",
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "PlusJakartaSans",
              ),
            ),
            const Gap(10),
            Text(
              _getTrimmedSlotInfo(appState.selectedSlotInfo.value),
              style: const TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "PlusJakartaSans",
              ),
            ),
            const Spacer(), // pushes button to bottom
            ValueListenableBuilder(
              valueListenable: notificationGranted,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: AppElevatedButton(
                    Text(
                      "Turn on Notifications",
                      style: const TextStyle(
                        color: ColorConstants.whiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                    onPressed: () {},
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppElevatedButton(
                Text(
                  "Go to Appointment Screen",
                  style: const TextStyle(
                    color: ColorConstants.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: "PlusJakartaSans",
                  ),
                ),
                onPressed: _goToDashboard,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
