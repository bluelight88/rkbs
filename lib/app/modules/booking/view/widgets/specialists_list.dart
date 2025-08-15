import 'package:flutter/material.dart';

import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../model/booking_service_slot_model.dart' as service;

class SpecialistsList extends StatelessWidget {
  final List<service.Staff> staffList;
  final ValueNotifier<int> selectedStaff;
  final void Function(int) onSelectStaff;

  const SpecialistsList({
    super.key,
    required this.staffList,
    required this.selectedStaff,
    required this.onSelectStaff,
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
                    : const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ValueListenableBuilder<int>(
            valueListenable: selectedStaff,
            builder: (context, value, _) {
              return GestureDetector(
                onTap: () => onSelectStaff(index),
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
