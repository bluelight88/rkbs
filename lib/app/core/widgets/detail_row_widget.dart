import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../utils/constants/color_constants.dart';

class DetailRowWidget extends StatelessWidget {
  final String title, subtitle;

  const DetailRowWidget({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Row build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 5,
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: ColorConstants.primaryColor),
        ),
      ),
      const Gap(5),
      Expanded(
        flex: 5,
        child: Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontSize: 13, height: 2),
        ),
      ),
    ],
  );
}

class DetailRowWidgetWithChild extends StatelessWidget {
  final String title;
  final Widget child;

  const DetailRowWidgetWithChild({
    required this.title,
    required this.child,
    super.key,
  });

  @override
  Row build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: ColorConstants.primaryColor),
        ),
      ),
      child,
    ],
  );
}
