import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../../utils/constants/color_constants.dart';
import '../dialog/spin_kit/spin_kit_fading_circle.dart';

final class CenterLoader extends StatelessWidget {
  final double height, width;

  const CenterLoader({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  @override
  SizedBox build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: const Align(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
}

final class SpinKitLoader extends StatelessWidget {
  final Color color;
  const SpinKitLoader({super.key, this.color = ColorConstants.primaryColor});

  @override
  Widget build(BuildContext context) => SpinKitFadingCircle(color: color);
}

final class SpinKitLoaderWithToolTip extends StatelessWidget {
  final Color color;
  final String toolTip;

  const SpinKitLoaderWithToolTip({
    required this.toolTip,
    super.key,
    this.color = ColorConstants.primaryColor,
  });

  @override
  Row build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(color: color),
          const Gap(10),
          Text(toolTip),
        ],
      );
}

final class BackgroundFadingSpinKitLoader extends StatelessWidget {
  const BackgroundFadingSpinKitLoader({super.key});

  @override
  Align build(BuildContext context) => Align(
        child: Material(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitLoader(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

final class LoadingWidget extends StatelessWidget {
  final double? height, width;
  const LoadingWidget({super.key, this.height, this.width});

  @override
  SizedBox build(BuildContext context) => SizedBox(
        height: height,
        width: width,
        child: const BackgroundFadingSpinKitLoader(),
      );
}
