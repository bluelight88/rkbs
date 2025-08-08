import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/models/cart_service_model.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/booking/view/widgets/booking_service_cart.dart';
import 'package:timoraa/app/modules/booking/view/widgets/date_picker.dart';
import 'package:timoraa/app/modules/booking/view/widgets/specialist_staff_card.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/extensions/app_extension.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/app_state.dart';
import 'package:timoraa/app/utils/services/util_methods.dart';

import '../../../core/widgets/custom/center_loader_widget.dart';
import '../../../core/widgets/custom/center_message_widget.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/manager/get_it_manager.dart';
import '../../../utils/manager/storage_manager.dart';
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

  @override
  void dispose() {
    appState.cartItems.removeWhere(
      (item) => item.serviceId == widget.services.servicesId,
    );
    getIt<StorageManager>().removeData(AppConstants.cartItems);
    super.dispose();
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
        serviceId: widget.services.servicesId,
        staffId: selectedStaff.value,
        date: formattedDate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight =
        screenHeight * 0.3 > 230 ? 265 : screenHeight * 0.4;
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: BlocConsumer<BookingServiceBloc, BookingServiceState>(
        listener: (context, state) async {
          if (state is BookingServiceSuccess) {
            _staffList = List.from(state.model.staff);
            if (_staffList.isNotEmpty) {
              selectedStaff.value = _staffList[0].staffId;
            }
            if (state.model.bookingSlot.isNotEmpty) {
              _calculateTotal(state.model.bookingSlot[0]);
            }
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
                selectedSlotInfo.value = UtilMethods.instance
                    .getFormattedSlotInfo(
                      selectedDate: selectedDate.value,
                      selectedSlot: firstAvailableSlot.slotDisplayTime,
                      slotDuration:
                          state.model.bookingSlot[0].cost[0].servicesDuration,
                    );
              }
            }
            final primaryService = CartServiceModel(
              serviceId: widget.services.servicesId,
              staffId: selectedStaff.value,
              slotId: selectedTimeSlotId.value,
              slotName:
                  selectedSlotInfo.value.isNotEmpty
                      ? selectedSlotInfo.value
                      : selectedTimeSlot.value,
              serviceDuration: widget.services.servicesCost[0].servicesDuration,
              serviceName: widget.services.servicesCode,
              cost: widget.services.servicesCost[0].cost,
            );
            final alreadyExists = appState.cartItems.any(
              (item) => item.serviceId == primaryService.serviceId,
            );
            if (!alreadyExists) {
              appState.cartItems.insert(0, primaryService);
              await getIt<StorageManager>().saveDynamicList(
                AppConstants.cartItems,
                appState.cartItems.map((e) => e.toJson()).toList(),
              );
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
                        SpecialistStaffCard(
                          selectedStaff: selectedStaff,
                          callback: () {
                            _getBookingRecord();
                          },
                          staffList: _staffList,
                        ),
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
                            return ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: appState.cartItems.length,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (context, index) {
                                final serviceItem = appState.cartItems[index];
                                final staffName =
                                    _staffList
                                        .firstWhere(
                                          (staff) =>
                                              staff.staffId ==
                                              serviceItem.staffId,
                                          orElse:
                                              () =>
                                                  _staffList.isNotEmpty
                                                      ? _staffList[0]
                                                      : service.Staff(
                                                        staffId: 0,
                                                        selectedStaff: 0,
                                                        staffPhoto: "",
                                                        staffName: 'Anyone',
                                                      ),
                                        )
                                        .staffName;

                                final slotName = UtilMethods.instance
                                    .getSlotNameWithDuration(
                                      serviceItem.slotName,
                                      serviceItem.serviceDuration,
                                    );
                                return BookingServiceCart(
                                  serviceItem.serviceName,
                                  staffName,
                                  slotName,
                                  serviceItem.cost.toString(),
                                  index,
                                  () async {
                                    setState(() {
                                      if (index == 0) {
                                        context.pop();
                                      } else {
                                        appState.cartItems.removeAt(index - 1);
                                      }
                                    });
                                    await getIt<StorageManager>()
                                        .saveDynamicList(
                                          AppConstants.cartItems,
                                          appState.cartItems
                                              .map((e) => e.toJson())
                                              .toList(),
                                        );
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
                            await getIt<StorageManager>().saveDynamicList(
                              AppConstants.cartItems,
                              appState.cartItems
                                  .map((e) => e.toJson())
                                  .toList(),
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
                                        onPressed: () {},
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
                                  onTap: () async {
                                    final formatted = UtilMethods.instance
                                        .getSlotNameWithDuration(
                                          slot.slotDisplayTime,
                                          widget
                                              .services
                                              .servicesCost[0]
                                              .servicesDuration,
                                        );
                                    selectedTimeSlot.value =
                                        slot.slotDisplayTime;
                                    selectedTimeSlotId.value = slot.slotId;
                                    selectedSlotInfo.value = formatted;
                                    await _updateCartTimeForService(
                                      widget.services.servicesId,
                                      formatted,
                                    );
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

  Future<void> _updateCartTimeForService(
    int serviceId,
    String newSlotTime,
  ) async {
    final index = appState.cartItems.indexWhere(
      (item) => item.serviceId == serviceId,
    );
    if (index == -1) return;
    appState.cartItems[index].slotName = newSlotTime;
    await getIt<StorageManager>().saveDynamicList(
      AppConstants.cartItems,
      appState.cartItems.map((e) => e.toJson()).toList(),
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
