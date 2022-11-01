import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';

class NavigationData {
  NavigationData(BuildContext context) {
    _initAnimations(context);
  }

  late Animation<Offset> pageAnimation, navButtonsAnimation;

  _initAnimations(BuildContext context) {
    final animation = context.read<Animation<double>>();
    pageAnimation = Utils.animation<Offset>(Offset(0, 1), Offset(0, 0),
        Interval(0, .5, curve: Curves.easeInOutCubic), animation);

    navButtonsAnimation = Utils.animation<Offset>(
        Offset(0, 1), Offset(0, 0), Interval(.5, 1), animation);
  }
}
