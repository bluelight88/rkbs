import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/extensions/navigation_extension.dart';
import '../../../utils/services/app_state.dart';

final class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final bool showLeading;
  final bool isCenter;
  final double? leadingWidth;

  const CustomAppBar(
    this.title, {
    super.key,
    this.leading,
    this.isCenter = false,
    this.actions = const [],
    this.showLeading = true,
    this.leadingWidth,
  });

  @override
  AppBar build(BuildContext context) => AppBar(
    leadingWidth: leadingWidth,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: ColorConstants.primaryColor,
        fontFamily: "HelveticaNeueLTArabic",
      ),
    ),
    centerTitle: isCenter,
    leading:
        showLeading && context.canPop()
            ? leading ?? const AppBackButton()
            : null,
    actions: actions,
  );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  IconButton build(BuildContext context) => IconButton(
    onPressed: context.pop,
    icon: const Icon(Icons.arrow_back_ios_new_rounded),
  );
}
