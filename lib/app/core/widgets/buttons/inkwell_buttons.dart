import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class ChangeActivityButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback onTap;

  const ChangeActivityButton({
    required this.onTap,
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorConstants.greyColor,
              size: 12,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: ColorConstants.greyColor, fontSize: 12),
            ),
          ],
        ),
      );
}
