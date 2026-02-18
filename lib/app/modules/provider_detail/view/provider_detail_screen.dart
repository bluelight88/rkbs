import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/custom/shimmer_widget.dart';
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

class _ProviderDetailScreenState extends State<ProviderDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final List<String> tabs = ["Service", "Review", "Portfolio", "Details"];
  final ValueNotifier<bool> isCollapsed = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _getProviderDetail();
  }

  @override
  void dispose() {
    _fadeController.dispose();
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
              _fadeController.forward();
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

              return FadeTransition(
                opacity: _fadeAnimation,
                child: ValueListenableBuilder<int>(
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
                            iconTheme: const IconThemeData(
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
                              minHeight: 160,
                              maxHeight: 160,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 20,
                                  right: 20,
                                  bottom: 10,
                                ),
                                decoration: const BoxDecoration(
                                  color: ColorConstants.whiteColor,
                                  borderRadius: BorderRadius.only(
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
                                                style: const TextStyle(
                                                  color:
                                                      ColorConstants
                                                          .primaryColor,
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
                                                      ColorConstants
                                                          .primaryColor,
                                                ),
                                                const Gap(10),
                                                Expanded(
                                                  child: Text(
                                                    addressString,
                                                    style: const TextStyle(
                                                      color:
                                                          ColorConstants
                                                              .primaryColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                              final bool isSelected =
                                                  index == i;
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6.0,
                                                    ),
                                                child: GestureDetector(
                                                  onTap:
                                                      () =>
                                                          selectedIndex.value =
                                                              i,
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
                ),
              );
            }
            if (state is ProviderDetailFailure) {
              return FailureWidget(state.message);
            }
            return _buildSkeletonUI();
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
                      style: const TextStyle(
                        color: ColorConstants.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        fontFamily: "PlusJakartaSans",
                      ),
                    ),
                    onPressed: () {},
                    height: 45,
                  ),
                )
                : const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: ColorConstants.primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: ShimmerWidget.rectangular(height: 200),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 160,
            maxHeight: 160,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerWidget.rectangular(width: 200, height: 20),
                  const Gap(15),
                  const Row(
                    children: [
                      ShimmerWidget.circular(width: 20, height: 20),
                      Gap(10),
                      Expanded(child: ShimmerWidget.rectangular(height: 15)),
                    ],
                  ),
                  const Gap(20),
                  Row(
                    children: List.generate(
                      4,
                      (i) => const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: ShimmerWidget.rectangular(width: 80, height: 35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    ShimmerWidget.rectangular(width: 80, height: 80),
                    Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget.rectangular(height: 15),
                          Gap(8),
                          ShimmerWidget.rectangular(width: 150, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTabContent(int index, ProviderDetailModel model) {
    switch (index) {
      case 0:
        return [ServiceTab(providerDetailModel: model)];
      case 1:
        return [
          ReviewTab(providerId: widget.providerId),
        ];
      case 2:
        return [PortfolioTab(providerDetailModel: model)];
      case 3:
        return [DetailTab(providerDetailModel: model)];
      default:
        return [const SliverToBoxAdapter(child: SizedBox.shrink())];
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
