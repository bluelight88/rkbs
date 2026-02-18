import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/core/widgets/custom/shimmer_widget.dart';
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

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _getHomeData() {
    context.read<HomeBloc>().add(GetHomeRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: _buildContent(state),
        );
      },
    );
  }

  Widget _buildContent(HomeState state) {
    if (state is HomeSuccess) {
      return _buildHomeUI(false, state);
    }
    if (state is HomeFailure) {
      return FailureWidget(state.message, onRefresh: _getHomeData);
    }
    return _buildHomeUI(true, null);
  }

  Widget _buildHomeUI(bool isLoading, HomeState? state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ?
                  const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerWidget.rectangular(width: 80, height: 15),
                            Gap(5),
                            ShimmerWidget.rectangular(width: 150, height: 25),
                            Gap(5),
                            ShimmerWidget.rectangular(width: 120, height: 15),
                          ],
                        )
                      : ValueListenableBuilder(
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
                                    text: value.isNotEmpty ? "$value\n" : "USER\n",
                                    style: const TextStyle(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "PlusJakartaSans",
                                      fontSize: 22,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (value.isEmpty && context.mounted) {
                                          context.pushNamed(RouteName.authScreen);
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
                  isLoading
                      ? const ShimmerWidget.circular(width: 50, height: 50)
                      : ClipRRect(
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
              child: isLoading
                  ? const ShimmerWidget.rectangular(height: 50)
                  : InkWell(
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
                  const Text(
                    "Select Category",
                    style: TextStyle(
                      fontFamily: "PlusJakartaSans",
                      color: ColorConstants.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  if (!isLoading)
                    InkWell(
                      onTap: () {},
                      child: const Opacity(
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
                  separatorBuilder: (context, index) => const Gap(20),
                  itemCount: isLoading ? 6 : (state as HomeSuccess).homeResponseModel.business.length,
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return const Column(
                        children: [
                          ShimmerWidget.circular(width: 62, height: 62),
                          Gap(10),
                          ShimmerWidget.rectangular(width: 50, height: 12),
                        ],
                      );
                    }
                    final business = (state as HomeSuccess).homeResponseModel.business[index];
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 62,
                            width: 62,
                            padding: const EdgeInsets.all(15),
                            color: ColorConstants.primaryColor,
                            child: business.businesstypeLogoMobile.startsWith("https")
                                ? Image.network(
                                    business.businesstypeLogoMobile,
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
                          business.businesstypeName,
                          style: const TextStyle(
                            fontFamily: "PlusJakartaSans",
                            color: ColorConstants.lightPrimaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const Gap(10),
            if (isLoading)
              ...List.generate(2, (index) => _buildSkeletonSlider())
            else
              ...List.generate(
                (state as HomeSuccess).homeResponseModel.sections.length,
                (index) {
                  final section = state.homeResponseModel.sections[index];
                  final items = section.details;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      child: DynamicSlider(
                        title: section.title,
                        scrollDirection: Axis.horizontal,
                        items: items,
                        imageUrlGetter: (provider) => provider.imageUrl,
                        primaryTextGetter: (provider) => provider.providerName,
                        secondaryTextGetter: (provider) =>
                            "${provider.providerAddressline1}, ${provider.providerCity}",
                        badgeText: (provider) {
                          if (section.title.toLowerCase().contains("offer")) {
                            return "Subscribe Now";
                          } else if (provider.toJson().containsKey("recommend")) {
                            return "${provider.reviewRating} | ${provider.reviewCount} Reviews";
                          } else {
                            return "";
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonSlider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget.rectangular(width: 150, height: 20),
          const Gap(10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const Gap(15),
              itemBuilder: (context, index) => const ShimmerWidget.rectangular(
                width: 250,
                height: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
