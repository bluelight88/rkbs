import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/detail_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view_model/provider_detail/provider_detail_bloc.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../../../utils/constants/asset_constants.dart';
import 'menus/review_tab.dart';
import 'menus/service_tab.dart';

class ProviderDetailScreen extends StatefulWidget {
  final String title;
  final int providerId;

  const ProviderDetailScreen({
    required this.providerId,
    required this.title,
    super.key,
  });

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final List<String> tabs = ["Details", "Service", "Review", "Portfolio"];
  final List<Widget> tabScreens = [
    DetailTab(),
    ServiceTab(),
    ReviewTab(),
    Center(child: Text("Portfolio Screen", style: TextStyle(fontSize: 20))),
  ];

  @override
  void initState() {
    _getProviderDetail();
    super.initState();
  }

  void _getProviderDetail() {
    context.read<ProviderDetailBloc>().add(
      FetchProviderDetail(providerId: widget.providerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        widget.title,
        color: Colors.transparent,
        titleColor: ColorConstants.whiteColor,
      ),
      body: BlocBuilder<ProviderDetailBloc, ProviderDetailState>(
        builder: (context, state) {
          if (state is ProviderDetailSuccess) {
            final addressLines = [
              state.providerDetailModel.providerAddressline1,
              state.providerDetailModel.providerAddressline2,
              state.providerDetailModel.providerAddressline3,
              state.providerDetailModel.providerCity,
            ];
            final filteredAddress =
                addressLines.where((line) => line.trim().isNotEmpty).toList();
            final addressString =
                "${filteredAddress.sublist(0, filteredAddress.length - 1).join(", ")}\n${filteredAddress.last}";
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: Image.network(state.providerDetailModel.imageUrl),
                  ),
                  Positioned(
                    top: 250,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                      decoration: BoxDecoration(
                        color: ColorConstants.whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.providerDetailModel.providerName,
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PlusJakartaSans",
                            ),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              Image.asset(
                                AssetConstants.icLocation,
                                color: ColorConstants.primaryColor,
                              ),
                              const Gap(10),
                              Text(
                                addressString,
                                style: TextStyle(
                                  color: ColorConstants.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "PlusJakartaSans",
                                ),
                              ),
                            ],
                          ),
                          const Gap(10),
                          ValueListenableBuilder<int>(
                            valueListenable: selectedIndex,
                            builder: (context, index, _) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(tabs.length, (i) {
                                    final bool isSelected = index == i;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0,
                                      ),
                                      child: GestureDetector(
                                        onTap: () => selectedIndex.value = i,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isSelected
                                                    ? ColorConstants
                                                        .primaryColor
                                                    : ColorConstants
                                                        .greyBackGround,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            tabs[i],
                                            style: TextStyle(
                                              color:
                                                  isSelected
                                                      ? ColorConstants
                                                          .whiteColor
                                                      : ColorConstants
                                                          .primaryColor,
                                              fontSize: 16,
                                              fontFamily: "PlusJakartaSans",
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                          const Gap(10),
                          ValueListenableBuilder<int>(
                            valueListenable: selectedIndex,
                            builder: (context, index, _) {
                              return tabScreens[index];
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is ProviderDetailFailure) {
            return FailureWidget(state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
