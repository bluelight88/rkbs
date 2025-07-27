import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../menus/widgets/service_cards.dart';

class PackageViewScreen extends StatelessWidget {
  const PackageViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: const CustomAppBar(
        "Our Packages",
        color: ColorConstants.whiteColor,
        titleColor: ColorConstants.primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemBuilder: (context, index) {
          return ServiceCards(
            title: "Service",
            subTitle: "Services Description",
            onTap: () {},
            bottomChild: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "12 Month",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "PlusJakartaSans",
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Book Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "PlusJakartaSans",
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            middleChild: Flexible(
              child: Text(
                "\$ 200.0",
                maxLines: 1,
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontFamily: "PlusJakartaSans",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            child: SizedBox.shrink(),
          );
        },
        separatorBuilder: (context, index) => Gap(50),
        itemCount: 4,
      ),
    );
  }
}
