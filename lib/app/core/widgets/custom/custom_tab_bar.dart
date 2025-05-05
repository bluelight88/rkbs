import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;
  final ValueNotifier selectedTab;
  final List<Widget> tabList;
  final bool isScrollable, isDecoration;

  const CustomTabBar({
    required this.tabController,
    required this.selectedTab,
    required this.tabList,
    super.key,
    this.isScrollable = true,
    this.isDecoration = false,
  });

  @override
  DecoratedBox build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      border:
          isDecoration
              ? const Border(
                bottom: BorderSide(
                  color: ColorConstants.primaryColor,
                  width: 0.5,
                ),
              )
              : null,
    ),
    child: TabBar(
      onTap: (int index) => selectedTab.value = index,
      isScrollable: isScrollable,
      unselectedLabelColor: ColorConstants.greyColor,
      labelStyle: Theme.of(context).textTheme.titleSmall,
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: ColorConstants.primaryColor, width: 1.5),
        ),
        gradient: LinearGradient(
          colors: [
            ColorConstants.lightPrimaryColor,
            ColorConstants.lightPrimaryColor,
          ],
        ),
      ),
      controller: tabController,
      dividerColor: ColorConstants.shadowColor,
      labelColor: ColorConstants.primaryColor,
      tabs: List.generate(
        tabList.length,
        (index) => Container(
          height: 40,
          alignment: Alignment.center,
          child: tabList[index],
        ),
      ),
    ),
  );
}
