import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../../paint_and_animation/animated_buttons.dart';
import '../../../paint_and_animation/compound_animations.dart';
import 'intro_state.dart';

class DemoButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intro = context.read<IntroProvider>();
    final animation = context.read<Animation<double>>();
    return SlideAndFadeTransition(
      fade: intro.demoGridAnimation,
      progress: animation,
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: SECONDARY.withOpacity(.3),
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Showcase',
                  style: kStatusTextStyle,
                ),
              ),
            ),
            Expanded(
              child: IconAndTextButton(
                image: intro.github,
                link: 'https://github.com/Bluebar1/',
                interval: Interval(0, 1),
                icon: MyIcons.github,
                label: 'GitHub',
                bottomPadding: 3,
              ),
            ),
            Expanded(
              child: IconAndTextButton(
                image: intro.wikimap,
                link: 'https://bluebar1.github.io/wikimap/',
                interval: Interval(0.25, 1),
                icon: Icons.mail,
                label: 'iOS Style App Demo',
              ),
            ),
            Expanded(
              child: IconAndTextButton(
                image: intro.grapher,
                link: 'https://bluebar1.github.io/scroll_editor/',
                interval: Interval(0.5, 1),
                icon: Icons.access_alarms_rounded,
                label: 'Grapher Demo',
              ),
            ),
            Expanded(
              child: IconAndTextButton(
                image: intro.splash,
                link: 'https://bluebar1.github.io',
                interval: Interval(0.5, 1),
                icon: Icons.access_alarms_rounded,
                label: 'Splash Page Animation',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
