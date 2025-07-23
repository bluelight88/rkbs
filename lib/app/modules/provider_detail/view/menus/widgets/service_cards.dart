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
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 50,
            right: 0,
            left: 0,
            child: Container(
              height: 40,
              padding: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: bottomChild,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorConstants.primaryColor),
            ),
            padding: const EdgeInsets.only(
              left: 20,
              top: 10,
              bottom: 10,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
