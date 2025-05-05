import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

class CustomChipWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onDeleteTap;
  final bool isDeleteAble;
  final IconData iconData;
  final double iconSize, fontSize;

  const CustomChipWidget({
    required this.onDeleteTap,
    required this.text,
    required this.iconData,
    super.key,
    this.isDeleteAble = false,
    this.iconSize = 15,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 3),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: ColorConstants.whiteColor,
          border: Border.all(color: ColorConstants.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                      color: ColorConstants.primaryColor,
                    ),
              ),
            ),
            if (text != '' && isDeleteAble) const SizedBox(width: 4),
            if (isDeleteAble)
              InkWell(
                onTap: onDeleteTap,
                child: Icon(
                  iconData,
                  color: ColorConstants.primaryColor,
                ),
              )
          ],
        ),
      );
}
