import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../paint_and_animation/compound_animations.dart';
import '../../../responsive.dart';
import '../../../utils.dart';
import '../contact.dart';

const contactResponsiveMap = {
  ScreenType.desktop: const ContactDesktop(),
  ScreenType.tablet: const ContactTablet(),
  ScreenType.mobile: const ContactMobile()
};

class ContactData {
  ContactData(BuildContext context) {
    _initAnimations(context);
    _initResponsive(context);
  }

  /// Animations

  late Animation<double> animation;
  late Animation<Offset> pageAnimation, boxAnimation, headerTextPosition;
  late Animatable<FadePositionScale> contactMenuAnimation;

  void _initAnimations(BuildContext context) {
    animation = context.read<Animation<double>>();
    pageAnimation = Utils.animation<Offset>(Offset(0, 1), Offset(0, 0),
        Interval(0, .5, curve: Curves.easeInOutCubic), animation);
    boxAnimation = Utils.animation<Offset>(Offset(0, 1), Offset(0, 0),
        Interval(.5, 1, curve: Curves.easeInOutCubic), animation);
    contactMenuAnimation = Tween<FadePositionScale>(
            begin: const FadePositionScale(FadePosition(0, Offset(50, 50)), .9),
            end: const FadePositionScale(FadePosition(1, Offset(0, 0)), 1.0))
        .chain(CurveTween(curve: Interval(.6, .8)));
    headerTextPosition = Utils.animation<Offset>(
        Offset(0, 1), Offset(0, 0), Interval(.7, 1), animation);
  }

  /// Responsive

  late double mainBoxBorderRadius,
      mainBoxPadding,
      mainBoxMaxHeight,
      mainBoxMaxWidth;

  late Color headerBackgroundColor;

  void _initResponsive(BuildContext context) {
    final Responsive resp = context.read<Responsive>();
    final ScreenType screenType = resp.screenType;

    Function respInit = {
      // only 2 screen sizes for contact screen
      ScreenType.mobile: _initMobile,
      ScreenType.tablet: _initMobile,
      ScreenType.desktop: _initDesktop
    }[screenType]!;
    respInit();
  }

  void _initMobile() {
    mainBoxBorderRadius = 0;
    mainBoxPadding = 0;
    mainBoxMaxHeight = double.infinity;
    mainBoxMaxWidth = double.infinity;
    headerBackgroundColor = Colors.redAccent;
  }

  void _initDesktop() {
    mainBoxBorderRadius = 30;
    mainBoxPadding = 15;
    mainBoxMaxHeight = 700;
    mainBoxMaxWidth = 800;
    headerBackgroundColor = Colors.transparent;
  }
}
