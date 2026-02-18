import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/services/app_state.dart';

final class CustomBottomSheetContainer extends StatelessWidget {
  final Widget child;

  const CustomBottomSheetContainer({required this.child, super.key});

  @override
  ConstrainedBox build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: appState.getScreenHeight(percent: 0.9),
    ),
    child: SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 2.5,
              margin: const EdgeInsets.only(top: 15, bottom: 5),
              color: ColorConstants.primaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: child,
          ),
          const SizedBox(height: 15),
        ],
      ),
    ),
  );
}
