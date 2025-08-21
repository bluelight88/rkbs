import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_detail_model.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/detail_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/protfolio_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/review_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view/menus/service_tab.dart';
import 'package:timoraa/app/modules/provider_detail/view_model/provider_detail/provider_detail_bloc.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import '../../../core/widgets/buttons/app_outlined_buttons.dart';
import '../../../utils/constants/asset_constants.dart';
import '../../../utils/services/app_state.dart';

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
  final List<String> tabs = ["Service", "Review", "Portfolio", "Details"];
  final ValueNotifier<bool> isCollapsed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _getProviderDetail();
  }

  @override
  void dispose() {
    appState.selectedSaloon.value = '';
    appState.selectedSaloonAddress.value = '';
    super.dispose();
  }

  void _getProviderDetail() {
    context.read<ProviderDetailBloc>().add(
      FetchProviderDetail(providerId: widget.providerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.primaryColor,
        body: BlocConsumer<ProviderDetailBloc, ProviderDetailState>(
          listener: (context, state) {
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
                  "${filteredAddress.sublist(0, filteredAddress.length - 1).join(", ")}, ${filteredAddress.last}";
              appState.selectedSaloon.value =
                  state.providerDetailModel.providerName;
              appState.selectedSaloonAddress.value = addressString;
            }
          },
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
                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification.metrics.axis == Axis.vertical) {
                        final metrics = notification.metrics;
                        final renderBox =
                            context.findRenderObject() as RenderBox?;
                        if (renderBox != null) {
                          final offset = metrics.pixels;
                          final collapsedHeight =
                              kToolbarHeight +
                              MediaQuery.of(context).padding.top;
                          final isNowCollapsed =
                              offset >= (200 - collapsedHeight);
                          if (isCollapsed.value != isNowCollapsed) {
                            isCollapsed.value = isNowCollapsed;
                          }
                        }
                      }
                      return false;
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 200,
                          pinned: true,
                          backgroundColor: ColorConstants.primaryColor,
                          iconTheme: IconThemeData(
                            color: ColorConstants.whiteColor,
                          ),
                          centerTitle: true,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            title: ValueListenableBuilder<bool>(
                              valueListenable: isCollapsed,
                              builder: (context, collapsed, _) {
                                return collapsed
                                    ? Text(
                                      state.providerDetailModel.providerName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontFamily: "PlusJakartaSans",
                                      ),
                                    )
                                    : const SizedBox.shrink();
                              },
                            ),
                            collapseMode: CollapseMode.parallax,
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  state.providerDetailModel.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withValues(alpha: 0.8),
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.7),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                              child: ValueListenableBuilder(
                                valueListenable: isCollapsed,
                                builder: (context, value, child) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (!value)
                                            Text(
                                              state
                                                  .providerDetailModel
                                                  .providerName,
                                              style: TextStyle(
                                                color:
                                                    ColorConstants.primaryColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "PlusJakartaSans",
                                              ),
                                            ),
                                          if (!value)
                                            const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Image.asset(
                                                AssetConstants.icLocation,
                                                color:
                                                    ColorConstants.primaryColor,
                                              ),
                                              const Gap(10),
                                              Expanded(
                                                child: Text(
                                                  addressString,
                                                  style: TextStyle(
                                                    color:
                                                        ColorConstants
                                                            .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        "PlusJakartaSans",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(tabs.length, (
                                            i,
                                          ) {
                                            final bool isSelected = index == i;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6.0,
                                                  ),
                                              child: GestureDetector(
                                                onTap:
                                                    () =>
                                                        selectedIndex.value = i,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                      fontFamily:
                                                          "PlusJakartaSans",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        ..._buildTabContent(index, state.providerDetailModel),
                      ],
                    ),
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
            return value == 1
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
      ),
    );
  }

  List<Widget> _buildTabContent(
    int index,
    ProviderDetailModel providerDetailModel,
  ) {
    switch (index) {
      case 0:
        return [
          providerDetailModel.services.isEmpty
              ? SliverToBoxAdapter(
                child: Container(
                  color: ColorConstants.whiteColor,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: Text(
                      "No services found.",
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 16,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                  ),
                ),
              )
              : SliverToBoxAdapter(
                child: ServiceTab(providerDetailModel: providerDetailModel),
              ),
        ];
      case 1:
        return [ReviewTab(providerDetailModel: providerDetailModel)];
      case 2:
        return [
          SliverToBoxAdapter(
            child: PortfolioTab(providerDetailModel: providerDetailModel),
          ),
        ];
      case 3:
        return [
          SliverToBoxAdapter(
            child: DetailTab(providerDetailModel: providerDetailModel),
          ),
        ];
      default:
        return [const SliverToBoxAdapter(child: SizedBox.shrink())];
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 130;

  @override
  double get maxExtent => 130;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => true;
}
