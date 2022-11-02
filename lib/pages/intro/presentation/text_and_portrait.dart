import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../../paint_and_animation/compound_animations.dart';
import '../../../paint_and_animation/painters.dart';
import '../../../responsive.dart';
import 'intro_modules.dart';
import 'intro_state.dart';

class TextAndPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intro = context.read<IntroProvider>();
    final app = context.read<Responsive>();
    final children = [
      Expanded(
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: FadePositionScaleTransition(
                fade: intro.textAnimation,
                progress: context.read<Animation<double>>(),
                child: IntroText())),
      ),
      kPaddingWidget,
      Expanded(
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: FadePositionScaleTransition(
                fade: !app.isMobile ? intro.picAnimation : intro.textAnimation,
                progress: context.read<Animation<double>>(),
                child: PortraitImage())),
      ),
    ];
    return !app.isMobile
        ? Transform.scale(
            scale: (app.maxWidth > 1300 && app.isDesktop)
                ? 1 + (app.maxWidth / 7000)
                : 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children);
  }
}

class IntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        IntroTextModule(lines: ['Nicholas', 'Blaauboer'], style: NameTextStyle),
        kPaddingWidgetSmall,
        MyDirectionalDivider(LTR: true),
        kPaddingWidgetSmall,
        IntroTextModule(
          text: 'Software Engineer',
          style: kStatusTextStyle,
          colors: [SECONDARY_LIGHTER, kPrimaryRed, SECONDARY_LIGHTER],
        ),
        kPaddingWidgetSmall,
        MyDirectionalDivider(LTR: false),
        kPaddingWidgetSmall,
        IntroTextModule(lines: [
          'University at Albany',
          'B.A. in Computer Science',
          'Minors in Mathematics\nand Informatics '
        ], style: DegreeTextStyle)
      ]),
    );
  }
}

class PortraitImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final intro = context.read<IntroProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(alignment: AlignmentDirectional.center, children: [
        Container(
          height: 400,
          width: 290,
          child: IntroShaderListener(
            builder: (context, shader) => RepaintBoundary(
                child: CustomPaint(painter: BorderPainter(shader))),
          ),
        ),
        Container(
          height: 390,
          width: 280,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12), child: intro.portrait),
        )
      ]),
    );
  }
}
