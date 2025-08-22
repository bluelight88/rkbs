import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/dashboard/view/home/widget/dynamic_slider.dart';
import 'package:timoraa/app/modules/dashboard/view_model/home/home_bloc.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/constants/color_constants.dart';

class HomeScreen extends StatefulWidget {
  final TextEditingController searchController;

  const HomeScreen({super.key, required this.searchController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _getHomeData() {
    context.read<HomeBloc>().add(GetHomeRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: appState.loginUserName,
                          builder: (context, value, child) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "Hello ",
                                    style: TextStyle(
                                      color: ColorConstants.primaryColor,
                                      fontFamily: "PlusJakartaSans",
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        value.isNotEmpty
                                            ? "$value\n"
                                            : "USER\n",
                                    style: const TextStyle(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "PlusJakartaSans",
                                      fontSize: 22,
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            if (!value.isNotEmpty &&
                                                context.mounted) {
                                              context.pushNamed(
                                                RouteName.authScreen,
                                              );
                                            }
                                          },
                                  ),
                                  const TextSpan(
                                    text: "Welcome to Saloon",
                                    style: TextStyle(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "PlusJakartaSans",
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            AssetConstants.icBoardingImage,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () => appState.appPageIndex.value = 1,
                      child: IgnorePointer(
                        ignoring: true,
                        child: SearchTextFormField(
                          controller: widget.searchController,
                          labelText: "What Are You Looking For?",
                          enable: false,
                          onChanged: (_) {},
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Category",
                          style: TextStyle(
                            fontFamily: "PlusJakartaSans",
                            color: ColorConstants.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // todo: show all other element of list
                          },
                          child: Opacity(
                            opacity: 0.5,
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w600,
                                fontFamily: "PlusJakartaSans",
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return Gap(20);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 62,
                                  width: 62,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  color: ColorConstants.primaryColor,
                                  child:
                                      state
                                              .homeResponseModel
                                              .business[index]
                                              .businesstypeLogoMobile
                                              .startsWith("https")
                                          ? Image.network(
                                            state
                                                .homeResponseModel
                                                .business[index]
                                                .businesstypeLogoMobile,
                                            height: 32,
                                            width: 32,
                                            fit: BoxFit.fitHeight,
                                          )
                                          : Image.asset(
                                            AssetConstants.icBackgroundImage,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              ),
                              const Gap(10),
                              Text(
                                state
                                    .homeResponseModel
                                    .business[index]
                                    .businesstypeName,
                                style: TextStyle(
                                  fontFamily: "PlusJakartaSans",
                                  color: ColorConstants.lightPrimaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: state.homeResponseModel.business.length,
                      ),
                    ),
                  ),
                  const Gap(10),
                  const Gap(10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: DynamicSlider(
                      title: "Special Offers",
                      scrollDirection: Axis.horizontal,
                      items: state.homeResponseModel.offer,
                      imageUrlGetter: (offer) => offer.imageUrl,
                      primaryTextGetter: (offer) => offer.providerName,
                      secondaryTextGetter:
                          (offer) =>
                              "${offer.providerAddressline1}, ${offer.providerCity}",
                      badgeText: (badge) => "Subscribe Now",
                    ),
                  ),
                  const Gap(10),
                  Divider(
                    height: 2,
                    color: ColorConstants.searchFieldTextColor,
                    endIndent: 20,
                    indent: 20,
                  ),
                  const Gap(10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: DynamicSlider(
                      title: "Barber Near You",
                      scrollDirection: Axis.horizontal,
                      items: state.homeResponseModel.recommended,
                      imageUrlGetter: (recommended) => recommended.imageUrl,
                      primaryTextGetter:
                          (recommended) => recommended.providerName,
                      secondaryTextGetter:
                          (recommended) =>
                              "${recommended.providerAddressline1}, ${recommended.providerCity}",
                      badgeText: (badge) => "4.9 | 8993 Reviews",
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is HomeFailure) {
          return FailureWidget(state.message, onRefresh: _getHomeData);
        }
        return LoadingWidget();
      },
    );
  }
}
