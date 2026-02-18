import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../utils/constants/color_constants.dart';

class ServiceCards extends StatelessWidget {
  final String title, subTitle;
  final GestureTapCallback onTap;
  final Widget child, bottomChild, middleChild;

  const ServiceCards({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.child,
    required this.bottomChild,
    required this.middleChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstants.primaryColor),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorConstants.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        subTitle,
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                middleChild,
                const Gap(10),
                child,
              ],
            ),
          ),
          InkWell(onTap: onTap, child: bottomChild),
        ],
      ),
    );
  }
}
