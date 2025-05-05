import 'package:flutter/material.dart';

import '../../utils/constants/asset_constants.dart';
import '../../utils/constants/color_constants.dart';

class AppLogo extends StatelessWidget {
  final double widthCustom;

  const AppLogo({required this.widthCustom, super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                blurRadius: 20,
                color: ColorConstants.shadowColor)
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          AssetConstants.appLogo,
          width: widthCustom,
        ),
      ),
    );
  }
}
