import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/services/app_state.dart';
import '../buttons/app_outlined_buttons.dart';

final class CenterMessageWidget extends StatelessWidget {
  final String text;
  final double height, width;
  final GestureTapCallback? onRefresh;

  const CenterMessageWidget(
    this.text, {
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.onRefresh,
  });

  @override
  SizedBox build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Center(
      child:
          onRefresh != null
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, textAlign: TextAlign.center),
                  const Gap(5),
                  AppOutlinedIconButton(
                    icon: const Icon(Icons.refresh_outlined),
                    onPressed: onRefresh ?? () {},
                    width: 125,
                    outlineColor: ColorConstants.primaryColor,
                    child: Text(
                      appState.localization.refresh,
                      style: const TextStyle(height: 1.5),
                    ),
                  ),
                ],
              )
              : Text(text, textAlign: TextAlign.center),
    ),
  );
}

final class FailureWidget extends StatelessWidget {
  final String msg;
  final double height, width;
  final GestureTapCallback? onRefresh;

  const FailureWidget(
    this.msg, {
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.onRefresh,
  });

  @override
  CenterMessageWidget build(BuildContext context) => CenterMessageWidget(
    msg,
    height: height,
    width: width,
    onRefresh: onRefresh,
  );
}
