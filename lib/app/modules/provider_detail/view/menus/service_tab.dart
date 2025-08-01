import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/widgets/service_cards.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';

import '../../model/provider_detail_model.dart';

class ServiceTab extends StatefulWidget {
  final ProviderDetailModel providerDetailModel;

  const ServiceTab({required this.providerDetailModel, super.key});

  @override
  State<ServiceTab> createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  late TextEditingController searchController;
  List<Service> filteredServices = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredServices = widget.providerDetailModel.services;
  }

  void _onSearchChanged(String value) {
    setState(() {
      filteredServices =
          widget.providerDetailModel.services.where((service) {
            final title = service.servicesCode.toLowerCase();
            final description = service.servicesDescription.toLowerCase();
            final query = value.toLowerCase();
            return title.contains(query) || description.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: ColorConstants.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight * 0.6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextFormField(
              controller: searchController,
              labelText: "Search Services",
              onChanged: _onSearchChanged,
              enable: true,
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
            Text(
              "Popular Services",
              style: TextStyle(
                color: ColorConstants.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "PlusJakartaSans",
              ),
            ),
            const Gap(10),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: filteredServices.length,
              separatorBuilder: (_, __) => const Gap(10),
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return ServiceCards(
                  title: service.servicesCode,
                  subTitle: service.servicesDescription,
                  onTap: () {
                    context.pushNamed(RouteName.bookingScreen);
                  },
                  bottomChild: Container(
                    height: 40,
                    padding: EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "PlusJakartaSans",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  middleChild: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${service.servicesCost[0].cost}",
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
                          "${service.servicesCost[0].servicesDuration} Mins.",
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
                    onPressed: () {
                      context.pushNamed(RouteName.packageViewScreen);
                    },
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                );
              },
            ),
            const Gap(70),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
