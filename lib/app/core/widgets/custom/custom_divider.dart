import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class CustomDivider extends StatelessWidget {
  final Color color;
  final double thickness, verticalPadding;

  const CustomDivider({
    super.key,
    this.color = ColorConstants.lightPrimaryColor,
    this.thickness = 3,
    this.verticalPadding = 4,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Divider(thickness: thickness, color: color),
  );
}
