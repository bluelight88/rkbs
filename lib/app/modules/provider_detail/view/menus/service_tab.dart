import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/widgets/service_cards.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';

import '../../model/provider_detail_model.dart';

class ServiceTab extends StatelessWidget {
  final ProviderDetailModel providerDetailModel;
  const ServiceTab({required this.providerDetailModel, super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Container(
      decoration: BoxDecoration(color: ColorConstants.whiteColor),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SearchTextFormField(
            controller: searchController,
            labelText: "labelText",
            onChanged: (val) {},
          ),
          const Gap(10),
          AppElevatedButton(
            const Text(
              "Venue Health & Safety Rules",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "PlusJakartaSans",
                fontSize: 14,
              ),
            ),
            height: 40,
            onPressed: () {},
          ),
          const Gap(10),
          ListView.separated(
            padding: const EdgeInsets.only(bottom: 70),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (_, __) => const Gap(50),
            itemBuilder: (context, index) {
              return ServiceCards(
                title: "Hair Cuts",
                subTitle: "Hair Cuts",
                onTap: () {},
                bottomChild: const Center(
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "PlusJakartaSans",
                      fontSize: 14,
                    ),
                  ),
                ),
                middleChild: Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "200",
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        "30 Min",
                        maxLines: 1,
                        style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontFamily: "PlusJakartaSans",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                child: AppElevatedButton(
                  const Text(
                    "Subscribe",
                    style: TextStyle(
                      color: ColorConstants.whiteColor,
                      fontFamily: "PlusJakartaSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {},
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
