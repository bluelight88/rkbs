import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/constants/asset_constants.dart';

class ReviewBookingScreen extends StatelessWidget {
  const ReviewBookingScreen({super.key});

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
      appBar: CustomAppBar(
        "Review and Confirm",
        color: ColorConstants.whiteColor,
        titleColor: ColorConstants.primaryColor,
      ),
      backgroundColor: ColorConstants.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.7,
              child: Text(
                _getTrimmedSlotInfo(appState.selectedSlotInfo.value),
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 18,
                  fontFamily: "PlusJakartaSans",
                ),
              ),
            ),
            const Gap(20),
            Text(
              appState.selectedSaloon.value,
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "PlusJakartaSans",
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Image.asset(
                  AssetConstants.icLocation,
                  color: ColorConstants.primaryColor,
                  height: 20,
                  width: 20,
                ),
                const Gap(10),
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    appState.selectedSaloonAddress.value,
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontSize: 14,
                      fontFamily: "PlusJakartaSans",
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.greyColor,
                    spreadRadius: 0,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                separatorBuilder: (context, index) {
                  if (index == appState.cartItems.length - 1) {
                    return SizedBox.shrink(); // No divider before total row
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      color: ColorConstants.searchFieldTextColor,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                  );
                },
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == appState.cartItems.length &&
                      appState.cartItems.isNotEmpty) {
                    final total = appState.cartItems.fold<double>(
                      0,
                      (sum, item) => sum + item.cost,
                    );
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Divider(
                            color: ColorConstants.searchFieldTextColor,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PlusJakartaSans",
                                ),
                              ),
                              Text(
                                "\$${total.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PlusJakartaSans",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            appState.cartItems[index].serviceName,
                            maxLines: 2,
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 18,
                              fontFamily: "PlusJakartaSans",
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$${appState.cartItems[index].cost.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "PlusJakartaSans",
                              ),
                            ),
                            const Gap(10),
                            Opacity(
                              opacity: 0.5,
                              child: Text(
                                appState.cartItems[index].slotName
                                            .split(',')
                                            .length >
                                        1
                                    ? appState.cartItems[index].slotName
                                                .split(',')[1]
                                                .split('-')
                                                .length >
                                            2
                                        ? '${appState.cartItems[index].slotName.split(',')[1].split('-')[0].trim()} - ${appState.cartItems[index].slotName.split(',')[1].split('-')[1].trim()}'
                                        : appState.cartItems[index].slotName
                                            .split(',')[1]
                                            .trim()
                                    : appState.cartItems[index].slotName,
                                style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 18,
                                  fontFamily: "PlusJakartaSans",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: appState.cartItems.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
