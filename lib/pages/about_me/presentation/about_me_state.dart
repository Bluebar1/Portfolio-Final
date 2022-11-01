import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../paint_and_animation/compound_animations.dart';
import '../../../responsive.dart';
import '../../../utils.dart';

class AboutMeData {
  AboutMeData(BuildContext context) {
    _initAnimations(context);
  }
  late Animation<double> sectionHeaderTextSize,
      sectionBodyTextSize,
      verticalBarSize;

  late Animation<Offset> pageAnimation;

  late Animatable<FadePositionScale> boxAnimation;

  _initAnimations(BuildContext context) {
    final animation = context.read<Animation<double>>();
    final constraints = context.read<Responsive>().constraints;
    boxAnimation = Tween<FadePositionScale>(
            begin:
                const FadePositionScale(FadePosition(0, Offset(100, 50)), .9),
            end: const FadePositionScale(FadePosition(1, Offset(0, 0)), 1.0))
        .chain(CurveTween(curve: Interval(.5, .7, curve: Curves.easeInOut)));

    sectionHeaderTextSize =
        Utils.animation<double>(0, 1, Interval(.8, 1), animation);

    sectionBodyTextSize =
        Utils.animation<double>(0, 1, Interval(.6, 1), animation);

    verticalBarSize = Utils.animation<double>(
        0, 1, Interval(.5, 1, curve: Curves.easeInOutCirc), animation);

    pageAnimation = Utils.animation<Offset>(
        Offset(1, 0),
        Offset(0, 0),
        Interval(0, .5,
            curve: (constraints.maxWidth > 1800)
                ? Curves.linear
                : Curves.easeInOutCirc),
        animation);
  }
}
