import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

class DetailTab extends StatelessWidget {
  DetailTab({super.key});

  final ValueNotifier<bool> showFullWeek = ValueNotifier<bool>(false);

  final Map<String, String> weeklySchedule = {
    'Sunday': '9:00 AM - 3:00 PM',
    'Monday': '9:00 AM - 3:00 PM',
    'Tuesday': '9:00 AM - 3:00 PM',
    'Wednesday': '9:00 AM - 3:00 PM',
    'Thursday': '9:00 AM - 3:00 PM',
    'Friday': '9:00 AM - 3:00 PM',
    'Saturday': '9:00 AM - 3:00 PM',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstants.whiteColor),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(10),
          const Text(
            "About Us",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "PlusJakartaSans",
            ),
          ),
          const Gap(10),
          const Text(
            "Neque porro quisquam est qui dolorem ipsum quia dolor sit"
            " amet, consectetur, adipisci velit...3.7 high street, HA87EJ"
            " Edgware 3.7 high street, HA87EJ, Edgware",
            style: TextStyle(fontSize: 14, fontFamily: "PlusJakartaSans"),
          ),

          const Gap(20),
          const Text(
            "Staffers",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "PlusJakartaSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 5),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        AssetConstants.icBackgroundImage,
                        fit: BoxFit.cover,
                        height: 54,
                        width: 54,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "User Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        "0100 010 0101",
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.greyText,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppElevatedButton(
                    const Text(
                      "Call Now",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 30,
                    onPressed: () {},
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: 3,
          ),
          const Gap(20),
          ValueListenableBuilder<bool>(
            valueListenable: showFullWeek,
            builder: (context, isExpanded, _) {
              return Column(
                children: [
                  if (!isExpanded)
                    _buildScheduleCard("Today", "9:00 AM - 3:00 PM")
                  else
                    ...weeklySchedule.entries.map(
                      (e) => _buildScheduleCard(e.key, e.value),
                    ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () => showFullWeek.value = !showFullWeek.value,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isExpanded ? "Hide Week" : "See Full Week",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: "PlusJakartaSans",
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const Gap(20),  const Gap(20),
          const Text(
            "Social Media & Share",
            style: TextStyle(
              fontSize: 18,
              fontFamily: "PlusJakartaSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(10),
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: 65,
                    decoration: BoxDecoration(
                      color: ColorConstants.greyBackGround2,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: const Icon(Icons.social_distance, size: 40),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Gap(20),
              itemCount: 5,
            ),
          ),
          const Gap(20),
          const Text(
            "Venue Amenities",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "PlusJakartaSans",
            ),
          ),
          const Gap(10),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  const Icon(Icons.social_distance, size: 25),
                  const Gap(10),
                  const Text(
                    "data",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "PlusJakartaSans",
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String day, String time) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
              fontFamily: "PlusJakartaSans",
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "PlusJakartaSans",
            ),
          ),
        ],
      ),
    );
  }
}
