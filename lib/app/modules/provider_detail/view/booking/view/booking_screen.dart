import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/provider_detail/view/booking/view/widgets/date_picker.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import '../../../../../utils/constants/asset_constants.dart';
import 'package:intl/intl.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final ValueNotifier<String> selectedSlotInfo = ValueNotifier<String>("");
  final ValueNotifier<String> selectedTimeSlot = ValueNotifier<String>('');
  final ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );

  final ValueNotifier<double> totalPrice = ValueNotifier<double>(0.0);
  final List<Map<String, dynamic>> services = [
    {
      'title': 'Hair Cuts',
      'specialist': 'Kevin Smith',
      'time': '09:30 AM - 10:00 AM',
      'price': '\$25.00',
    },
    {
      'title': 'Beard Trim',
      'specialist': 'John Smith',
      'time': '10:00 AM - 10:30 AM',
      'price': '\$15.00',
    },
    {
      'title': 'Hair Wash',
      'specialist': 'Olive Smith',
      'time': '10:30 AM - 11:00 AM',
      'price': '\$10.00',
    },
  ];

  @override
  void initState() {
    _calculateTotal();
    super.initState();
  }

  void _calculateTotal() {
    final total = services.fold<double>(0.0, (sum, item) {
      final priceString =
          item['price'].toString().replaceAll(RegExp(r'[^\d.]'), '').trim();
      final price = double.tryParse(priceString) ?? 0.0;
      return sum + price;
    });
    totalPrice.value = total;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double headerHeight =
        screenHeight * 0.3 > 270 ?  screenHeight * 0.3 : screenHeight * 0.4;

    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: CustomScrollView(
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
                  children: const [
                    Row(
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
                    Gap(10),
                    CustomDatePicker(),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  _buildTimeSlots(),
                  const Gap(10),
                  const Divider(height: 1, thickness: 2),
                  const Gap(10),
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: services.length,
                    separatorBuilder: (context, index) => Gap(10),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return _buildServiceCard(
                        service['title'],
                        service['specialist'],
                        service['time'],
                        service['price'],
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
                    onPressed: () {
                      setState(() {
                        services.add({
                          'title': 'Beard Trim',
                          'specialist': 'John Smith',
                          'time': '10:30 AM - 11:00 AM',
                          'price': '\$20.00',
                        });
                        _calculateTotal();
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<double>(
                    valueListenable: totalPrice,
                    builder: (context, value, _) {
                      return Center(
                        child: Text(
                          '\$${value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            fontFamily: "PlusJakartaSans",
                          ),
                        ),
                      );
                    },
                  ),
                  const Gap(10),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedSlotInfo,
                    builder: (context, value, _) {
                      return value.isNotEmpty
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
                          : SizedBox.shrink();
                    },
                  ),
                  const Gap(10),
                  ValueListenableBuilder<String>(
                    valueListenable: selectedSlotInfo,
                    builder: (context, value, _) {
                      return value.isNotEmpty
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
                          : SizedBox.shrink();
                    },
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlots() {
    final timeSlots = {
      'Morning Slot': ['09:00 AM', '09:30 AM', '10:00 AM'],
      'Afternoon Slot': ['12:00 AM', '01:30 AM', '02:30 AM'],
      'Evening Slot': ['05:00 PM', '05:30 PM', '06:00 PM'],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          timeSlots.entries.map((entry) {
            final slotName = entry.key;
            final slots = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slotName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "PlusJakartaSans",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(8),
                ValueListenableBuilder<String>(
                  valueListenable: selectedTimeSlot,
                  builder: (context, selectedValue, _) {
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          slots.map((slot) {
                            final isSelected = selectedValue == slot;
                            return InkWell(
                              onTap: () {
                                final formatted = _getFormattedSlotInfo(
                                  context,
                                  selectedDate.value,
                                  slot,
                                );
                                selectedTimeSlot.value = slot;
                                selectedSlotInfo.value = formatted;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? ColorConstants.primaryColor
                                          : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? ColorConstants.primaryColor
                                            : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: Text(
                                  slot,
                                  style: TextStyle(
                                    color:
                                        isSelected
                                            ? ColorConstants.whiteColor
                                            : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "PlusJakartaSans",
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                const Gap(16),
              ],
            );
          }).toList(),
    );
  }

  String _getFormattedSlotInfo(
    BuildContext context,
    DateTime date,
    String startTime,
  ) {
    final day = DateFormat('EEE d').format(date);

    final time = TimeOfDay(
      hour: int.parse(startTime.split(':')[0]),
      minute: int.parse(startTime.split(':')[1].split(' ')[0]),
    );

    final isPM = startTime.toLowerCase().contains('pm');
    final adjustedHour = isPM && time.hour < 12 ? time.hour + 12 : time.hour;

    final correctedTime = TimeOfDay(hour: adjustedHour, minute: time.minute);
    final newMinute = (correctedTime.minute + 60) % 60;
    final newHour =
        (correctedTime.hour + ((correctedTime.minute + 60) ~/ 60)) % 24;

    final endTime = TimeOfDay(hour: newHour, minute: newMinute);
    return "$day, ${correctedTime.format(context)} - ${endTime.format(context)} - 1 hrs";
  }

  Widget _buildSpecialists() {
    final specialists = [
      {'name': 'Kevin Smith', 'image': 'https://via.placeholder.com/60'},
      {'name': 'John Smith', 'image': 'https://via.placeholder.com/60'},
      {'name': 'Olive Smith', 'image': 'https://via.placeholder.com/60'},
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: specialists.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final s = specialists[index];
          return Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  AssetConstants.icBackgroundImage,
                  height: 54,
                  width: 54,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                s['name']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "PlusJakartaSans",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
  ) {
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
                    price,
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
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  services.removeWhere(
                    (s) =>
                        s['title'] == title &&
                        s['specialist'] == specialistName &&
                        s['time'] == time &&
                        s['price'] == price,
                  );
                  _calculateTotal();
                });
              },
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
