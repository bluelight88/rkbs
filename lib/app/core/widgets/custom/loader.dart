import 'package:flutter/material.dart';

final class CenterLoaderWidget extends StatelessWidget {
  final double height, width;

  const CenterLoaderWidget({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  @override
  SizedBox build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: const Align(child: CircularProgressIndicator.adaptive()),
  );
}
