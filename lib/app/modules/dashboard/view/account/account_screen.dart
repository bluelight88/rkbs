import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/constants/color_constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Manage Your Profile")),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppElevatedButton(
            Text(
              "Logout",
              style: TextStyle(
                color: ColorConstants.whiteColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: "PlusJakartaSans",
              ),
            ),
            onPressed: () {
              appState.clearAllValues();
              appState.cartItems.clear();
              appState.setUserImage = '';
              appState.setUserId = "";
              appState.setSessionId = '';
              appState.setUserName = '';
              appState.selectedTimeSlot.value = '';
              appState.selectedSlotInfo.value = '';
              appState.selectedSaloon.value = '';
              appState.selectedSaloonAddress.value = '';
              appState.totalPrice.value = 0.0;
            },
          ),
        ),
      ],
    );
  }
}
