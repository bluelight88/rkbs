import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:timoraa/app/core/widgets/custom/toast_utils.dart';
import 'package:timoraa/app/modules/booking/view/booking_selection/widgets/date_picker.dart';
import 'package:timoraa/app/modules/booking/view/booking_selection/widgets/fixed_header_delegate.dart';
import 'package:timoraa/app/modules/booking/view/booking_selection/widgets/service_card.dart';
import 'package:timoraa/app/modules/booking/view/booking_selection/widgets/specialists_list.dart';
import 'package:timoraa/app/modules/booking/view/booking_selection/widgets/time_slots.dart';
import 'package:timoraa/app/utils/extensions/app_extension.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../core/models/cart_service_model.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../core/widgets/custom/center_loader_widget.dart';
import '../../../../core/widgets/custom/center_message_widget.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../../../utils/constants/route_name.dart';
import '../../../provider_detail/model/provider_detail_model.dart';
import '../../model/booking_service_slot_model.dart' as service;
import '../../view_model/booking_service_bloc.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Service services;

  const BookAppointmentScreen({super.key, required this.services});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final ValueNotifier<int> selectedTimeSlotId = ValueNotifier<int>(0);
  final ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
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
    appState.totalPrice.value = total;
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
                appState.selectedTimeSlot.value =
                    firstAvailableSlot.slotDisplayTime;
                appState.selectedSlotInfo.value = _getFormattedSlotInfo(
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
                  delegate: FixedHeaderDelegate(
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
                            callback: () => _getBookingRecord(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child:
                      state.model.bookingSlot[0].afternoonSlot.isEmpty &&
                              state.model.bookingSlot[0].morningSlot.isEmpty &&
                              state.model.bookingSlot[0].eveningSlot.isEmpty
                          ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Text(
                                "No slots available for today, please change date",
                              ),
                            ),
                          )
                          : Padding(
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
                                SpecialistsList(
                                  staffList: _staffList,
                                  selectedStaff: selectedStaff,
                                  onSelectStaff: _onSelectStaff,
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
                                TimeSlots(
                                  model: state.model,
                                  selectedDate: selectedDate,
                                  selectedTimeSlotId: selectedTimeSlotId,
                                  selectedTimeSlot: appState.selectedTimeSlot,
                                  selectedSlotInfo: appState.selectedSlotInfo,
                                ),
                                const Gap(10),
                                const Divider(height: 1, thickness: 2),
                                const Gap(10),
                                ValueListenableBuilder(
                                  valueListenable: appState.selectedSlotInfo,
                                  builder: (context, slotValue, _) {
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
                                        serviceName:
                                            widget.services.servicesCode,
                                        cost:
                                            state
                                                .model
                                                .bookingSlot[0]
                                                .cost[0]
                                                .cost,
                                      ),
                                      ...appState.cartItems,
                                    ];

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...allServices.map((service) {
                                          final staffName =
                                              _staffList
                                                  .firstWhere(
                                                    (staff) =>
                                                        staff.staffId ==
                                                        service.staffId,
                                                    orElse: () => _staffList[0],
                                                  )
                                                  .staffName;
                                          final slotName =
                                              service.slotName
                                                          .split(',')
                                                          .length >
                                                      1
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
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            child: ServiceCard(
                                              title: service.serviceName,
                                              specialistName: staffName,
                                              time: slotName,
                                              price: service.cost
                                                  .toStringAsFixed(2),
                                              serviceId: service.serviceId,
                                              mainServiceId: service.serviceId,
                                              onRemove: () {
                                                appState.cartItems.removeWhere(
                                                  (item) =>
                                                      item.serviceId ==
                                                      service.serviceId,
                                                );
                                                appState.totalPrice.value =
                                                    appState.cartItems.fold(
                                                      0.0,
                                                      (sum, item) =>
                                                          sum + item.cost,
                                                    );
                                              },
                                            ),
                                          );
                                        }),
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
                                            ToastUtils.showBusy(
                                              message: "Under Development",
                                            );
                                          },
                                        ),
                                        Gap(16),
                                        ValueListenableBuilder<double>(
                                          valueListenable: appState.totalPrice,
                                          builder:
                                              (context, value, _) => Center(
                                                child: Text(
                                                  '\$${value.toStringAsFixed(2)}',
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w800,
                                                    fontFamily:
                                                        "PlusJakartaSans",
                                                  ),
                                                ),
                                              ),
                                        ),
                                        const Gap(10),
                                        ValueListenableBuilder<String>(
                                          valueListenable:
                                              appState.selectedSlotInfo,
                                          builder:
                                              (context, value, _) =>
                                                  value.isNotEmpty
                                                      ? Center(
                                                        child: Text(
                                                          value,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                            letterSpacing: 0,
                                                            color: Colors.grey,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                "PlusJakartaSans",
                                                          ),
                                                        ),
                                                      )
                                                      : const SizedBox.shrink(),
                                        ),
                                        const Gap(10),
                                        ValueListenableBuilder<String>(
                                          valueListenable:
                                              appState.selectedSlotInfo,
                                          builder:
                                              (context, value, _) =>
                                                  value.isNotEmpty
                                                      ? AppElevatedButton(
                                                        const Text(
                                                          'Book Now',
                                                          style: TextStyle(
                                                            color:
                                                                ColorConstants
                                                                    .whiteColor,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "PlusJakartaSans",
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          if (!appState.cartItems.any(
                                                            (item) =>
                                                                item.serviceId ==
                                                                widget
                                                                    .services
                                                                    .servicesId,
                                                          )) {
                                                            appState.cartItems.add(
                                                              CartServiceModel(
                                                                serviceId:
                                                                    widget
                                                                        .services
                                                                        .servicesId,
                                                                staffId:
                                                                    selectedStaff
                                                                        .value,
                                                                slotId:
                                                                    selectedTimeSlotId
                                                                        .value,
                                                                slotName:
                                                                    appState
                                                                        .selectedSlotInfo
                                                                        .value,
                                                                serviceDuration:
                                                                    widget
                                                                        .services
                                                                        .servicesCost[0]
                                                                        .servicesDuration,
                                                                serviceName:
                                                                    widget
                                                                        .services
                                                                        .servicesCode,
                                                                cost:
                                                                    state
                                                                        .model
                                                                        .bookingSlot[0]
                                                                        .cost[0]
                                                                        .cost,
                                                              ),
                                                            );
                                                          }
                                                          context.pushNamed(
                                                            RouteName
                                                                .authScreen,
                                                            args: {
                                                              "fromBooking":
                                                                  true,
                                                            },
                                                          );
                                                        },
                                                      )
                                                      : const SizedBox.shrink(),
                                        ),
                                        const Gap(40),
                                      ],
                                    );
                                  },
                                ),
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
