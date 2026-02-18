import 'package:flutter/material.dart';

import '../../../utils/extensions/navigation_extension.dart';

final class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Color color;
  final Color titleColor;
  final List<Widget> actions;
  final bool showLeading;
  final bool isCenter;
  final double? leadingWidth;

  const CustomAppBar(
    this.title, {
    super.key,
    this.leading,
    required this.color,
    required this.titleColor,
    this.isCenter = true,
    this.actions = const [],
    this.showLeading = true,
    this.leadingWidth,
  });

  @override
  AppBar build(BuildContext context) => AppBar(
    backgroundColor: color,
    leadingWidth: leadingWidth,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: titleColor,
        fontFamily: "PlusJakartaSans",
      ),
    ),
    centerTitle: true,
    leading:
        showLeading && context.canPop()
            ? leading ?? AppBackButton(color: titleColor)
            : null,
    actions: actions,
  );

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class AppBackButton extends StatelessWidget {
  final Color color;

  const AppBackButton({required this.color, super.key});

  @override
  IconButton build(BuildContext context) => IconButton(
    onPressed: context.pop,
    icon: Icon(Icons.arrow_back_sharp, color: color),
  );
}
