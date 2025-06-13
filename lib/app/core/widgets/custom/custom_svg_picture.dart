import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

final class CustomSvgPicture extends StatelessWidget {
  final String image;
  final BoxFit boxFit;
  final Color? color;
  final double? width, height;

  const CustomSvgPicture(
    this.image, {
    super.key,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.color,
  });

  @override
  SvgPicture build(BuildContext context) => SvgPicture.asset(
    image,
    fit: boxFit,
    width: width,
    height: height,
    // ignore: deprecated_member_use
    color: color,
  );
}
