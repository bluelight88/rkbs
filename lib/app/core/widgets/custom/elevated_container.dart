import 'package:flutter/cupertino.dart';

import '../../../utils/constants/color_constants.dart';

final class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double verticalPadding,
      horizontalPadding,
      borderRadius,
      blurRadius,
      width,
      verticalMargin,
      horizontalMargin;
  final AlignmentGeometry? alignment;

  const ElevatedContainer({
    required this.child,
    super.key,
    this.horizontalPadding = 0,
    this.verticalPadding = 0,
    this.horizontalMargin = 10,
    this.verticalMargin = 10,
    this.borderRadius = 8,
    this.blurRadius = 10,
    this.width = double.infinity,
    this.alignment,
  });

  @override
  Container build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(
      horizontal: horizontalMargin,
      vertical: verticalMargin,
    ),
    padding: EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    ),
    width: width,
    alignment: alignment,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      color: ColorConstants.whiteColor,
      boxShadow: [
        BoxShadow(color: ColorConstants.shadowColor, blurRadius: blurRadius),
      ],
      borderRadius: BorderRadius.circular(borderRadius),
    ),
    child: child,
  );
}
