import 'package:flutter/material.dart';

import '../../../constants/global_constants.dart';
import '../../../responsive.dart';
import 'demo_buttons.dart';
import 'intro_buttons.dart';
import 'intro_modules.dart';
import 'text_and_portrait.dart';

const introResponsiveMap = {
  ScreenType.desktop: const IntroDesktop(),
  ScreenType.tablet: const IntroTablet(),
  ScreenType.mobile: const IntroMobile()
};

class IntroDesktop extends StatelessWidget {
  const IntroDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      DesktopNavMenu(),
      Expanded(
        child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: TextAndPortrait()),
        ),
      ),
      DemoButtons()
    ]);
  }
}

class IntroTablet extends StatelessWidget {
  const IntroTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: kForegroundMaxWidth),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FittedBox(fit: BoxFit.fitWidth, child: IntroNavigation()),
        kPaddingWidgetLarge,
        Flexible(child: TextAndPortrait())
      ]),
    ));
  }
}

class IntroMobile extends StatelessWidget {
  const IntroMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Padding(
          padding: const EdgeInsets.only(top: 50), child: TextAndPortrait()),
      Align(alignment: Alignment.topLeft, child: RouteToNavButton())
    ]);
  }
}
