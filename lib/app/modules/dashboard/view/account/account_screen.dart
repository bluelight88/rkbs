import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/buttons/app_elevated_button.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/route_name.dart';
import 'package:timoraa/app/utils/extensions/navigation_extension.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/constants/color_constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Settings",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PlusJakartaSans",
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  const Gap(15),
                  _buildMenuContainer([
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: "My Profile",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.calendar_today_outlined,
                      title: "My Bookings",
                      onTap: () {
                        appState.appPageIndex.value = 2;
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.favorite_border,
                      title: "Favorites",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.payment_outlined,
                      title: "Payment Methods",
                      onTap: () {},
                    ),
                  ]),
                  const Gap(25),
                  const Text(
                    "General",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PlusJakartaSans",
                      color: ColorConstants.primaryColor,
                    ),
                  ),
                  const Gap(15),
                  _buildMenuContainer([
                    _buildMenuItem(
                      icon: Icons.notifications_none_outlined,
                      title: "Notifications",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: "Help Center",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: "About Us",
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () {},
                    ),
                  ]),
                  const Gap(30),
                  _buildLogoutButton(context),
                  const Gap(40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      stretch: true,
      backgroundColor: ColorConstants.primaryColor,
      elevation: 0,
      centerTitle: false,
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 15),
        title: LayoutBuilder(
          builder: (context, constraints) {
            final double top = constraints.biggest.height;
            // The value here needs to be slightly more than kToolbarHeight to trigger correctly
            final bool isCollapsed = top <= kToolbarHeight + MediaQuery.of(context).padding.top + 10;
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isCollapsed ? 1.0 : 0.0,
              child: ValueListenableBuilder(
                valueListenable: appState.loginUserName,
                builder: (context, name, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: appState.userImage.isNotEmpty && appState.userImage.startsWith('http')
                            ? Image.network(appState.userImage, height: 26, width: 26, fit: BoxFit.cover)
                            : Image.asset(AssetConstants.icBoardingImage, height: 26, width: 26, fit: BoxFit.cover),
                      ),
                      const Gap(10),
                      Text(
                        name.isNotEmpty ? name : "Guest User",
                        style: const TextStyle(
                          color: ColorConstants.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "PlusJakartaSans",
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Container(
          color: ColorConstants.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(30),
              _buildProfileImage(),
              const Gap(15),
              ValueListenableBuilder(
                valueListenable: appState.loginUserName,
                builder: (context, name, _) {
                  return Text(
                    name.isNotEmpty ? name : "Guest User",
                    style: const TextStyle(
                      color: ColorConstants.whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PlusJakartaSans",
                    ),
                  );
                },
              ),
              const Gap(5),
              Text(
                appState.userMail.isNotEmpty && appState.userMail != "-"
                    ? appState.userMail
                    : "Find your style",
                style: TextStyle(
                  color: ColorConstants.whiteColor.withValues(alpha:0.8),
                  fontSize: 14,
                  fontFamily: "PlusJakartaSans",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: ColorConstants.whiteColor,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: appState.userImage.startsWith('http')
                  ? NetworkImage(appState.userImage)
                  : const AssetImage(AssetConstants.icBoardingImage) as ImageProvider,
            ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withValues(alpha:0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 22,
                color: ColorConstants.primaryColor,
              ),
            ),
            const Gap(15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: "PlusJakartaSans",
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    if (appState.userId.isEmpty) {
      return AppElevatedButton(
        const Text(
          "Login / Sign Up",
          style: TextStyle(
            color: ColorConstants.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: "PlusJakartaSans",
          ),
        ),
        onPressed: () {
          context.pushNamed(RouteName.authScreen);
        },
      );
    }

    return AppElevatedButton(
      const Text(
        "Logout",
        style: TextStyle(
          color: ColorConstants.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: "PlusJakartaSans",
        ),
      ),
      backgroundColor: ColorConstants.primaryColor,
      onPressed: () {
        appState.clearAllValues();
        appState.cartItems.clear();
        appState.setUserImage = '';
        appState.setUserId = "";
        appState.setSessionId = '';
        appState.setUserName = '';
        appState.selectedTimeSlot.value = '';
        appState.selectedSlotInfo.value = '';
        appState.selectedSaloon.value = '';
        appState.selectedSaloonAddress.value = '';
        appState.loginUserName.value = '';
        appState.totalPrice.value = 0.0;
        appState.appPageIndex.value = 0;
        context.pushReplacementNamed(RouteName.splashScreen);
      },
    );
  }
}
