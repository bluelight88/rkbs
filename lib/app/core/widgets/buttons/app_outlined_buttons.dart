import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class SVGOutlinedButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height;
  final Color outlineColor;

  const SVGOutlinedButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.width = 50,
    this.outlineColor = ColorConstants.primaryColor,
    this.height = 45,
  });

  @override
  OutlinedButton build(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      maximumSize: Size(width, height),
      minimumSize: Size(width, height),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: BorderSide(color: outlineColor),
      foregroundColor: outlineColor,
    ),
    child: child,
  );
}

final class AppOutlinedButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color outlineColor;

  const AppOutlinedButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.outlineColor = ColorConstants.primaryColor,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: BorderSide(color: outlineColor),
      foregroundColor: outlineColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    ),
    child: child,
  );
}

final class AppOutlinedIconButton extends StatelessWidget {
  final Widget child, icon;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color outlineColor;

  const AppOutlinedIconButton({
    required this.child,
    required this.icon,
    required this.onPressed,
    super.key,
    this.outlineColor = ColorConstants.redColor,
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
      side: BorderSide(color: outlineColor),
      foregroundColor: outlineColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    icon: icon,
    label: child,
  );
}
