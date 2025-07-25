import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

class DetailTab extends StatelessWidget {
  const DetailTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstants.whiteColor),
      padding: EdgeInsets.symmetric(horizontal: 20),
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
}
