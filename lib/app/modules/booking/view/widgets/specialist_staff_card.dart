import 'package:flutter/material.dart';

import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../model/booking_service_slot_model.dart';

class SpecialistStaffCard extends StatelessWidget {
  final ValueNotifier<int> selectedStaff;
  final VoidCallback callback;
  final List<Staff> staffList;
  const SpecialistStaffCard({
    required this.callback,
    required this.selectedStaff,
    required this.staffList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: staffList.length,
        separatorBuilder:
            (context, index) =>
                index == 0
                    ? VerticalDivider(
                      width: 30,
                      thickness: 2,
                      endIndent: 20,
                      indent: 5,
                      color: Colors.grey.shade400,
                    )
                    : SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ValueListenableBuilder<int>(
            valueListenable: selectedStaff,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) return;
                  final temp = staffList[0];
                  staffList[0] = staffList[index];
                  staffList[index] = temp;
                  selectedStaff.value = staffList[0].staffId;
                  callback();
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color:
                              value == staffList[index].staffId
                                  ? ColorConstants.primaryColor
                                  : Colors.transparent,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Image.asset(
                          AssetConstants.icBackgroundImage,
                          height: 54,
                          width: 54,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      staffList[index].staffName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "PlusJakartaSans",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
