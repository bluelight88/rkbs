import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/models/cart_service_model.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/booking/view/widgets/date_picker.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:intl/intl.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/app_extension.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../core/widgets/custom/center_loader_widget.dart';
import '../../../core/widgets/custom/center_message_widget.dart';
import '../../../utils/constants/asset_constants.dart';
import '../../provider_detail/model/provider_detail_model.dart';
import '../model/booking_service_slot_model.dart' as service;
import '../view_model/booking_service_bloc.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Service services;

  const BookAppointmentScreen({super.key, required this.services});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final ValueNotifier<String> selectedSlotInfo = ValueNotifier<String>("");
  final ValueNotifier<String> selectedTimeSlot = ValueNotifier<String>('');
  final ValueNotifier<int> selectedTimeSlotId = ValueNotifier<int>(0);
  final ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<double> totalPrice = ValueNotifier<double>(0.0);
  final ValueNotifier<int> selectedStaff = ValueNotifier<int>(0);

  List<service.Staff> _staffList = [];

  @override
  void initState() {
    _getBookingRecord();
    super.initState();
  }

  void _calculateTotal(service.BookingSlot bookingSlot) {
    final total = bookingSlot.cost.fold<double>(0.0, (sum, item) {
      final priceString =
          item.cost.toString().replaceAll(RegExp(r'[^\d.]'), '').trim();
      final price = double.tryParse(priceString) ?? 0.0;
      return sum + price;
    });
    totalPrice.value = total;
  }

  void _getBookingRecord() {
    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(selectedDate.value, now);

    final formattedDate =
        isToday
            ? selectedDate.value.formatDate("yyyy-MM-dd HH:mm")
            : selectedDate.value.formatDate("yyyy-MM-dd");
    context.read<BookingServiceBloc>().add(
      BookingServiceList(
        providerId: 1,
        serviceId: 1,
        staffId: selectedStaff.value,
        date: formattedDate,
      ),
    );
  }

  void _onSelectStaff(int index) {
    if (index == 0) return;
    final temp = _staffList[0];
    _staffList[0] = _staffList[index];
    _staffList[index] = temp;
    selectedStaff.value = _staffList[0].staffId;
    _getBookingRecord();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight =
        screenHeight * 0.3 > 230 ? 265 : screenHeight * 0.4;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: BlocConsumer<BookingServiceBloc, BookingServiceState>(
        listener: (context, state) {
          if (state is BookingServiceSuccess) {
            _staffList = List.from(state.model.staff);
            selectedStaff.value = _staffList[0].staffId;
            _calculateTotal(state.model.bookingSlot[0]);
            final bookingSlot = state.model.bookingSlot.firstOrNull;
            if (bookingSlot != null) {
              final firstAvailableSlot =
                  [
                    ...bookingSlot.morningSlot,
                    ...bookingSlot.afternoonSlot,
                    ...bookingSlot.eveningSlot,
                  ].firstOrNull;
              if (firstAvailableSlot != null) {
                selectedTimeSlotId.value = firstAvailableSlot.slotId;
                selectedTimeSlot.value = firstAvailableSlot.slotDisplayTime;
                selectedSlotInfo.value = _getFormattedSlotInfo(
                  selectedDate: selectedDate.value,
                  selectedSlot: firstAvailableSlot.slotDisplayTime,
                  slotDuration:
                      state.model.bookingSlot[0].cost[0].servicesDuration,
                );
              }
            }
          }
        },
        builder: (context, state) {
          if (state is BookingServiceSuccess) {
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _FixedHeaderDelegate(
                    minExtentHeight: headerHeight,
                    maxExtentHeight: headerHeight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              BackButton(color: Colors.white),
                              Spacer(),
                              Text(
                                'Book Appointment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(flex: 2),
                            ],
                          ),
                          CustomDatePicker(
                            selectedDate: selectedDate,
                            callback: () {
                              _getBookingRecord();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose Specialist',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlusJakartaSans",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Gap(20),
                        _buildSpecialists(),
                        const Gap(24),
                        const Text(
                          'Time',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            fontFamily: "PlusJakartaSans",
                            color: ColorConstants.primaryColor,
                          ),
                        ),
                        const Gap(20),
                        _buildTimeSlots(state.model),
                        const Gap(10),
                        const Divider(height: 1, thickness: 2),
                        const Gap(10),
                        ValueListenableBuilder(
                          valueListenable: selectedSlotInfo,
                          builder: (context, slotValue, child) {
                            final allServices = <CartServiceModel>[
                              CartServiceModel(
                                serviceId: widget.services.servicesId,
                                staffId: selectedStaff.value,
                                slotId: selectedTimeSlotId.value,
                                slotName: slotValue,
                                serviceDuration:
                                    widget
                                        .services
                                        .servicesCost[0]
                                        .servicesDuration,
                                serviceName: widget.services.servicesCode,
                                cost: state.model.bookingSlot[0].cost[0].cost,
                              ),
                              ...appState.cartItems,
                            ];

                            return ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: allServices.length,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (context, index) {
                                final service = allServices[index];
                                final staffName =
                                    _staffList
                                        .firstWhere(
                                          (staff) =>
                                              staff.staffId == service.staffId,
                                          orElse: () => _staffList[0],
                                        )
                                        .staffName;

                                final slotName =
                                    service.slotName.split(',').length > 1
                                        ? service.slotName
                                                    .split(',')[1]
                                                    .split('-')
                                                    .length >
                                                2
                                            ? '${service.slotName.split(',')[1].split('-')[0].trim()} - ${service.slotName.split(',')[1].split('-')[1].trim()}'
                                            : service.slotName
                                                .split(',')[1]
                                                .trim()
                                        : service.slotName;

                                return _buildServiceCard(
                                  service.serviceName,
                                  staffName,
                                  slotName,
                                  service.cost.toString(),
                                  service.serviceId,
                                  onRemove: () {
                                    setState(() {
                                      if (index == 0) {
                                        context.pop();
                                      } else {
                                        // Remove from cart
                                        appState.cartItems.removeAt(index - 1);
                                      }
                                    });
                                  },
                                );
                              },
                            );
                          },
                        ),
                        const Gap(24),
                        AppElevatedButton(
                          const Text(
                            'Add Another Service',
                            style: TextStyle(
                              color: ColorConstants.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: "PlusJakartaSans",
                            ),
                          ),
                          onPressed: () async {
                            appState.cartItems.add(
                              CartServiceModel(
                                serviceId: widget.services.servicesId,
                                staffId: selectedStaff.value,
                                slotId: selectedTimeSlotId.value,
                                slotName: selectedTimeSlot.value,
                                serviceDuration:
                                    widget
                                        .services
                                        .servicesCost[0]
                                        .servicesDuration,
                                serviceName: widget.services.servicesCode,
                                cost: widget.services.servicesCost[0].cost,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        ValueListenableBuilder<double>(
                          valueListenable: totalPrice,
                          builder:
                              (context, value, _) => Center(
                                child: Text(
                                  '\$${value.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "PlusJakartaSans",
                                  ),
                                ),
                              ),
                        ),
                        const Gap(10),
                        ValueListenableBuilder<String>(
                          valueListenable: selectedSlotInfo,
                          builder:
                              (context, value, _) =>
                                  value.isNotEmpty
                                      ? Center(
                                        child: Text(
                                          value,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontFamily: "PlusJakartaSans",
                                          ),
                                        ),
                                      )
                                      : const SizedBox.shrink(),
                        ),

                        const Gap(10),
                        ValueListenableBuilder<String>(
                          valueListenable: selectedSlotInfo,
                          builder:
                              (context, value, _) =>
                                  value.isNotEmpty
                                      ? AppElevatedButton(
                                        const Text(
                                          'Book Now',
                                          style: TextStyle(
                                            color: ColorConstants.whiteColor,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "PlusJakartaSans",
                                          ),
                                        ),
                                        onPressed: () {
                                          context.pushNamed(RouteName.authScreen);
                                        },
                                      )
                                      : const SizedBox.shrink(),
                        ),

                        const Gap(40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is BookingServiceFailure) {
            return FailureWidget(state.message, onRefresh: _getBookingRecord);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Widget _buildTimeSlots(service.BookingServiceSlotModel model) {
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

  Widget _buildSpecialists() {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _staffList.length,
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
                onTap: () => _onSelectStaff(index),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color:
                              value == _staffList[index].staffId
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
                      _staffList[index].staffName,
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

  Widget _buildServiceCard(
    String title,
    String specialistName,
    String time,
    String price,
    int serviceId, {
    required VoidCallback onRemove,
  }) {
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
        if (widget.services.servicesId != serviceId)
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

class _FixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final Widget child;

  _FixedHeaderDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.child,
  });

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(elevation: 0, child: child);
  }

  @override
  bool shouldRebuild(covariant _FixedHeaderDelegate oldDelegate) {
    return oldDelegate.minExtentHeight != minExtentHeight ||
        oldDelegate.maxExtentHeight != maxExtentHeight ||
        oldDelegate.child != child;
  }
}

