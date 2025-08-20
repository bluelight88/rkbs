import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';

import '../../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../../utils/constants/asset_constants.dart';
import '../../../../../utils/constants/color_constants.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String specialistName;
  final String time;
  final String price;
  final int serviceId;
  final int mainServiceId;
  final VoidCallback onRemove;

  const ServiceCard({
    super.key,
    required this.title,
    required this.specialistName,
    required this.time,
    required this.price,
    required this.serviceId,
    required this.mainServiceId,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(
            right: 20,
            left: 10,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "\$ $price",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  const Text(
                    'Popular Services',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: "PlusJakartaSans",
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: "PlusJakartaSans",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 1),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Image.asset(
                      AssetConstants.icBackgroundImage,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    specialistName,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  AppElevatedButton(
                    width: 100,
                    height: 30,
                    borderRadius: 8,
                    const Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.whiteColor,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        if (mainServiceId != serviceId)
          Positioned(
            top: -5,
            right: -5,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onRemove,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 12, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
