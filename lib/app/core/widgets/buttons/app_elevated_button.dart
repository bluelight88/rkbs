import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class SVGElevatedButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height;

  const SVGElevatedButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.width = 50,
    this.height = 45,
  });

  @override
  ElevatedButton build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      maximumSize: Size(width, height),
      minimumSize: Size(width, height),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    child: child,
  );
}

final class AppElevatedButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor, foregroundColor;

  const AppElevatedButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.foregroundColor = ColorConstants.whiteColor,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 15,
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

final class AppElevatedIconButton extends StatelessWidget {
  final Widget child, icon;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor;

  const AppElevatedIconButton({
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

final class AppTextButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor, foregroundColor;
  final double horizontalPadding, verticalPadding;

  const AppTextButton(
    this.child, {
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.foregroundColor = ColorConstants.whiteColor,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 15,
    this.horizontalPadding = 8,
    this.verticalPadding = 5,
  });

  @override
  TextButton build(BuildContext context) => TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      maximumSize: Size(width, height),
      minimumSize: Size(width, height),
      side: BorderSide(color: backgroundColor),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    child: child,
  );
}

final class AppTextIconButton extends StatelessWidget {
  final Widget child, icon;
  final void Function() onPressed;
  final double width, height, borderRadius;
  final Color backgroundColor, foregroundColor;
  final double horizontalPadding, verticalPadding;

  const AppTextIconButton(
    this.child, {
    required this.icon,
    required this.onPressed,
    super.key,
    this.backgroundColor = ColorConstants.primaryColor,
    this.foregroundColor = ColorConstants.whiteColor,
    this.width = double.infinity,
    this.height = 40,
    this.borderRadius = 15,
    this.horizontalPadding = 8,
    this.verticalPadding = 5,
  });

  @override
  TextButton build(BuildContext context) => TextButton.icon(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      maximumSize: Size(width, height),
      minimumSize: Size(width, height),
      side: BorderSide(color: backgroundColor),
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    icon: icon,
    label: child,
  );
}
