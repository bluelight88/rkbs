import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../../utils/constants/asset_constants.dart';
import 'custom_svg_picture.dart';
import 'loader.dart';

final class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final Widget placeholderWidget, errorWidget;
  final double? height, width;

  const CustomNetworkImage(
    this.imageUrl, {
    super.key,
    this.boxFit = BoxFit.fill,
    this.height,
    this.width,
    this.errorWidget =
        const CustomSvgPicture(AssetConstants.appLogo),
    this.placeholderWidget = const CenterLoaderWidget(),
  });

  @override
  Widget build(BuildContext context) => imageUrl.isNotEmpty
      ? CachedNetworkImage(
          fit: boxFit,
          height: height,
          width: width,
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => errorWidget,
          placeholder: (context, url) => placeholderWidget,
        )
      : errorWidget;
}
