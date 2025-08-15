import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/color_constants.dart';
import '../../model/booking_service_slot_model.dart' as service;

class TimeSlots extends StatelessWidget {
  final service.BookingServiceSlotModel model;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<int> selectedTimeSlotId;
  final ValueNotifier<String> selectedTimeSlot;
  final ValueNotifier<String> selectedSlotInfo;

  const TimeSlots({
    super.key,
    required this.model,
    required this.selectedDate,
    required this.selectedTimeSlotId,
    required this.selectedTimeSlot,
    required this.selectedSlotInfo,
  });

  @override
  Widget build(BuildContext context) {
    final bookingSlot = model.bookingSlot.firstOrNull;
    if (bookingSlot == null) return const SizedBox();

    final slotMap = {
      'Morning Slot': bookingSlot.morningSlot,
      'Afternoon Slot': bookingSlot.afternoonSlot,
      'Evening Slot': bookingSlot.eveningSlot,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          slotMap.entries.map((entry) {
            final slotName = entry.key;
            final slotList = entry.value;
            if (slotList.isEmpty) return const SizedBox();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slotName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "PlusJakartaSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                ValueListenableBuilder<int>(
                  valueListenable: selectedTimeSlotId,
                  builder: (context, selectedValue, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            slotList.map((slot) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    final formatted = _getFormattedSlotInfo(
                                      selectedDate: selectedDate.value,
                                      selectedSlot: slot.slotDisplayTime,
                                      slotDuration: 30,
                                    );
                                    selectedTimeSlot.value =
                                        slot.slotDisplayTime;
                                    selectedTimeSlotId.value = slot.slotId;
                                    selectedSlotInfo.value = formatted;
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          selectedTimeSlotId.value ==
                                                  slot.slotId
                                              ? ColorConstants.primaryColor
                                              : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color:
                                            selectedTimeSlotId.value ==
                                                    slot.slotId
                                                ? ColorConstants.primaryColor
                                                : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      slot.slotDisplayTime,
                                      style: TextStyle(
                                        color:
                                            selectedTimeSlotId.value ==
                                                    slot.slotId
                                                ? ColorConstants.whiteColor
                                                : Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "PlusJakartaSans",
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    );
                  },
                ),
                const Gap(16),
              ],
            );
          }).toList(),
    );
  }

  String _getFormattedSlotInfo({
    required DateTime selectedDate,
    required String selectedSlot,
    required int slotDuration,
  }) {
    final cleanSlot =
        selectedSlot
            .replaceAll('\u202F', ' ')
            .replaceAll('\u00A0', ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim()
            .toUpperCase();

    final match = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)').firstMatch(cleanSlot);
    if (match == null) {
      throw FormatException('Invalid time format: $selectedSlot');
    }

    int hour = int.parse(match.group(1)!);
    int minute = int.parse(match.group(2)!);
    final period = match.group(3)!;

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    final startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      hour,
      minute,
    );
    final endDateTime = startDateTime.add(Duration(minutes: slotDuration));

    final day = DateFormat('EEE d').format(selectedDate).toUpperCase();
    final startFormatted = DateFormat.jm().format(startDateTime);
    final endFormatted = DateFormat.jm().format(endDateTime);

    return '$day, $startFormatted - $endFormatted - ${slotDuration}min';
  }
}
