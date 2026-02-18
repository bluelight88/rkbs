import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/util_methods.dart';

import '../../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../../utils/constants/asset_constants.dart';
import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/services/app_state.dart';

class BookingServiceCart extends StatelessWidget {
  final String title;
  final String specialistName;
  final ValueNotifier<String> time;
  final String price;
  final int index;
  final VoidCallback onRemove;

  const BookingServiceCart(
    this.title,
    this.specialistName,
    this.time,
    this.price,
    this.index,
    this.onRemove, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: time,
      builder: (context, value, child) {
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
                        "${appState.currencyName.value} $price",
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
                        UtilMethods.instance.extractCleanTimeRange(time.value),
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
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
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
            if (index != 0)
              Positioned(
                top: -3,
                right: -2,
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
                      child: const Icon(
                        Icons.close,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
