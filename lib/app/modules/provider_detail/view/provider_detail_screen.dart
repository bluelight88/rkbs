import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/detail_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/protfolio_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/review_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/service_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view_model/provider_detail/provider_detail_bloc.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import '../../../core/widgets/buttons/app_outlined_buttons.dart';
import '../../../utils/constants/asset_constants.dart';

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
      backgroundColor: ColorConstants.primaryColor,
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

            return ValueListenableBuilder<int>(
              valueListenable: selectedIndex,
              builder: (context, index, _) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      backgroundColor: ColorConstants.primaryColor,
                      iconTheme: IconThemeData(
                        color: ColorConstants.whiteColor,
                      ),
                      centerTitle: true,
                      title: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        background: Image.network(
                          state.providerDetailModel.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.whiteColor,
                            borderRadius: const BorderRadius.only(
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
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    AssetConstants.icLocation,
                                    color: ColorConstants.primaryColor,
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Text(
                                      addressString,
                                      style: TextStyle(
                                        color: ColorConstants.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "PlusJakartaSans",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SingleChildScrollView(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ..._buildTabContent(index),
                  ],
                );
              },
            );
          }
          if (state is ProviderDetailFailure) {
            return FailureWidget(state.message);
          }
          return const LoadingWidget();
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, child) {
          return value == 2
              ? Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppOutlinedButton(
                  Text(
                    "Write a review",
                    style: TextStyle(
                      color: ColorConstants.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      fontFamily: "PlusJakartaSans",
                    ),
                  ),
                  onPressed: () {},
                ),
              )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  List<Widget> _buildTabContent(int index) {
    switch (index) {
      case 0:
        return [SliverToBoxAdapter(child: DetailTab())];
      case 1:
        return [const SliverToBoxAdapter(child: ServiceTab())];
      case 2:
        return [const ReviewTab()];
      case 3:
        return [const SliverToBoxAdapter(child: PortfolioTab())];
      default:
        return [const SliverToBoxAdapter(child: SizedBox.shrink())];
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 160;

  @override
  double get maxExtent => 160;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
