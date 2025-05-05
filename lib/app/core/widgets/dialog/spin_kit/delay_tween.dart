import 'dart:math' as math show pi, sin;

import 'package:flutter/animation.dart';

final class DelayTween extends Tween<double> {
  DelayTween({required this.delay, super.begin, super.end});

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
