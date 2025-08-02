import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/modules/provider_detail/view/booking/view/widgets/date_picker.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../../../../../utils/constants/asset_constants.dart';

class BookAppointmentScreen extends StatelessWidget {
  const BookAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _FixedHeaderDelegate(
              minExtentHeight: MediaQuery.of(context).size.height * 0.4,
              maxExtentHeight: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const BackButton(color: Colors.white),
                        const Spacer(),
                        const Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                    CustomDatePicker(),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  _buildTimeSlots(),
                  const Gap(10),
                  Divider(height: 1, thickness: 2),
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
                  _buildServiceCard(
                    'Hair Cuts',
                    'Kevin Smith',
                    '09:30 AM - 10:00 AM',
                    '\$25.00',
                  ),
                  const SizedBox(height: 12),
                  _buildServiceCard(
                    'Wash & Style',
                    'Rohan Smith',
                    '10:30 AM - 11:00 AM',
                    '\$25.00',
                  ),
                  const Gap(24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Another Service',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      '\$50.00',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(24),
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
      'Morning Slot': [
        '09:30 AM',
        '10:00 AM',
        '10:30 AM',
        '11:00 AM',
        '11:30 AM',
      ],
      'Afternoon Slot': ['12:00 PM', '12:30 PM', '01:00 PM', '01:30 PM'],
      'Evening Slot': ['04:00 PM', '04:30 PM', '05:00 PM', '05:30 PM'],
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          timeSlots.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    fontFamily: "PlusJakartaSans",
                  ),
                ),
                const Gap(10),
                SizedBox(
                  height: 35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: entry.value.length,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final time = entry.value[index];
                      final isSelected =
                          time ==
                          '09:30 AM'; // replace with your selected logic

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            fontFamily: "PlusJakartaSans",
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(10),
              ],
            );
          }).toList(),
    );
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
    return Container(
      padding: const EdgeInsets.all(12),
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
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(price, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.close, size: 18),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Popular Services', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Row(
            children: [
              // const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://via.placeholder.com/40')),
              const SizedBox(width: 8),
              Text(specialistName),
              const Spacer(),
              Text(time, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

/// Pinned header delegate
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
    return Material(elevation: 4, child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
