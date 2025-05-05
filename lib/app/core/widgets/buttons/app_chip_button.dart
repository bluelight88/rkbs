import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class AppChipButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor, foregroundColor;

  const AppChipButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.foregroundColor = ColorConstants.whiteColor,
    this.width = double.infinity,
    this.height = 35,
    this.borderRadius = 5,
  });

  @override
  ElevatedButton build(BuildContext context) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          maximumSize: Size(width, height),
          minimumSize: Size(width, height),
          side: BorderSide(color: backgroundColor),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child,
      );
}

final class AppChipIconButton extends StatelessWidget {
  final Widget child, icon;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor;

  const AppChipIconButton({
    required this.child,
    required this.icon,
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.width = 50,
    this.height = 35,
    this.borderRadius = 50,
  });

  @override
  ElevatedButton build(BuildContext context) => ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          maximumSize: Size(width, height),
          minimumSize: Size(width, height),
          side: BorderSide(color: backgroundColor),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        icon: icon,
        label: child,
      );
}

final class AppChipOutlinedButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor, foregroundColor;

  const AppChipOutlinedButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.whiteColor,
    this.foregroundColor = ColorConstants.primaryColor,
    this.width = double.infinity,
    this.height = 35,
    this.borderRadius = 5,
  });

  @override
  OutlinedButton build(BuildContext context) => OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          maximumSize: Size(width, height),
          minimumSize: Size(width, height),
          side: BorderSide(color: foregroundColor),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child,
      );
}

final class AppChipOutlinedIconButton extends StatelessWidget {
  final Widget child, icon;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor;

  const AppChipOutlinedIconButton({
    required this.child,
    required this.icon,
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.width = 50,
    this.height = 35,
    this.borderRadius = 50,
  });

  @override
  OutlinedButton build(BuildContext context) => OutlinedButton.icon(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          maximumSize: Size(width, height),
          minimumSize: Size(width, height),
          side: BorderSide(color: backgroundColor),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        icon: icon,
        label: child,
      );
}
