import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_detail_model.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/extensions/app_extension.dart';

import '../../../../utils/constants/expandable_text.dart';
import '../../../../utils/services/util_methods.dart';

class DetailTab extends StatelessWidget {
  final ProviderDetailModel providerDetailModel;

  DetailTab({required this.providerDetailModel, super.key});

  final ValueNotifier<bool> showFullWeek = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstants.whiteColor),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About Us",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "PlusJakartaSans",
            ),
          ),
          const Gap(10),
          ExpandableText(
            text: UtilMethods.instance.cleanHtmlString(
              providerDetailModel.providerInfo,
            ),
            style: TextStyle(
              fontSize: 14,
              fontFamily: "PlusJakartaSans",
              color: ColorConstants.primaryColor,
            ),
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
          const Gap(10),
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
                  Text(
                    providerDetailModel.staff[index].staffName,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (providerDetailModel.staff[index].staffPhone.isNotEmpty)
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
            itemCount: providerDetailModel.staff.length,
          ),
          const Gap(20),
          ValueListenableBuilder<bool>(
            valueListenable: showFullWeek,
            builder: (context, isExpanded, _) {
              final String todayKey = DateFormat('EEEE').format(DateTime.now());

              final WorkingDay todayWorkingDay = providerDetailModel.workingDays
                  .firstWhere(
                    (day) =>
                        day.title.trim().toLowerCase() ==
                        todayKey.toLowerCase(),
                    orElse:
                        () => WorkingDay(
                          title: todayKey,
                          description: "No appointment for today",
                          logo: '',
                          link: '',
                        ),
                  );

              return Column(
                children: [
                  if (!isExpanded)
                    _buildScheduleCard("Today", todayWorkingDay.description)
                  else
                    ...providerDetailModel.workingDays.map(
                      (e) => _buildScheduleCard(e.title, e.description),
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
          const Gap(20),
          if (providerDetailModel.socialMedia.any((e) => e.link.isNotEmpty))
            const Text(
              "Social Media & Share",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "PlusJakartaSans",
                fontWeight: FontWeight.w600,
              ),
            ),

          if (providerDetailModel.socialMedia.any((e) => e.link.isNotEmpty))
            const Gap(10),
          if (providerDetailModel.socialMedia.any((e) => e.link.isNotEmpty))
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return providerDetailModel.socialMedia[index].link.isEmpty
                      ? SizedBox.shrink()
                      : InkWell(
                        onTap: () {
                          providerDetailModel.socialMedia[index].link
                              .launchUrl();
                        },
                        child: Container(
                          height: 60,
                          width: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorConstants.greyBackGround2,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            child: Image.network(
                              providerDetailModel.socialMedia[index].logo,
                            ),
                          ),
                        ),
                      );
                },
                separatorBuilder: (context, index) => const Gap(15),
                itemCount: providerDetailModel.socialMedia.length,
              ),
            ),
          if (providerDetailModel.socialMedia.any((e) => e.link.isNotEmpty))
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
                  Image.network(
                    providerDetailModel.amenities[index].logo,
                    height: 25,
                    width: 25, errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      providerDetailModel.amenities[2].logo, // replace with your fallback asset path
                      height: 25,
                      width: 25,
                    );
                  },
                  ),
                  const Gap(10),
                  Text(
                    providerDetailModel.amenities[index].title,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "PlusJakartaSans",
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: providerDetailModel.amenities.length,
          ),
          const Gap(20),
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
