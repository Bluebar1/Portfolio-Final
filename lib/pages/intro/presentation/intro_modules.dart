import 'package:flutter/material.dart';
import 'package:portfolio/pages/intro/presentation/intro_state.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../../paint_and_animation/compound_animations.dart';
import '../../../paint_and_animation/painters.dart';
import '../../../responsive.dart';
import '../../../route.dart';
import 'intro_buttons.dart';

class IntroShaderListener extends StatelessWidget {
  late Animation<double> controller;

  final double width = kForegroundMaxWidth;
  List<Color>? colors;
  late Animation<double> _colorShifter;

  final Widget Function(BuildContext, Shader) builder;

  IntroShaderListener({super.key, required this.builder, this.colors}) {
    colors ??= [SECONDARY, SECONDARY.withOpacity(.4), SECONDARY];
  }

  @override
  Widget build(BuildContext context) {
    controller = context.read<IntroProvider>().controller!;
    final colorShift = width * 10;
    final colorTween = Tween<double>(begin: 0, end: colorShift);

    _colorShifter = colorTween.animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 1.0, curve: Curves.easeInOutQuad),
    ));
    return context.select((IntroProvider p) => p.isFading)
        ? _workingShader(context)
        : AnimatedBuilder(
            animation: controller,
            builder: animatedBuilder,
          );
  }

  Widget animatedBuilder(BuildContext context, Widget? child) {
    return _workingShader(context);
  }

  _workingShader(BuildContext context) {
    final linearGradient = LinearGradient(colors: colors!).createShader(
        Rect.fromLTWH(-width * 2, _colorShifter.value, _colorShifter.value, 0));

    return builder(context, linearGradient);
  }
}

class IntroTextModule extends StatelessWidget {
  final List<String>? lines;
  final String? text;
  List<Color>? colors;

  final TextStyle style;

  IntroTextModule(
      {Key? key, required this.style, this.lines, this.text, this.colors}) {
    colors ??= [SECONDARY, SECONDARY.withOpacity(.4), SECONDARY];
  }

  @override
  Widget build(BuildContext context) {
    return lines == null
        ? _textWidget(text!)
        : Container(
            width: 300,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: lines!.length,
                itemBuilder: (BuildContext context, int index) {
                  return _textWidget(lines![index]);
                }));
  }

  Center _textWidget(String _txt) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: IntroShaderListener(
                colors: colors,
                builder: (context, shader) {
                  TextStyle _style =
                      TextStyle(foreground: Paint()..shader = shader);
                  return RepaintBoundary(
                    child: DefaultTextStyle.merge(
                        style: style,
                        child: Text(
                          _txt,
                          style: _style,
                          textAlign: TextAlign.center,
                        )),
                  );
                })));
  }
}

class TextWithShader extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Shader shader;
  final TextAlign? textAlign;

  const TextWithShader(
      {super.key,
      required this.text,
      required this.style,
      required this.shader,
      this.textAlign = TextAlign.center});
  @override
  Widget build(BuildContext context) {
    var _style = TextStyle(foreground: Paint()..shader = shader);

    return DefaultTextStyle.merge(
      style: style,
      child: Text(
        text,
        style: _style,
        textAlign: textAlign,
      ),
    );
  }
}

class MyDirectionalDivider extends StatelessWidget {
  final bool LTR;
  const MyDirectionalDivider({
    Key? key,
    required this.LTR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
          height: 10,
          width: 190,
          child: CustomPaint(painter: DividerPainter(LTR))),
    );
  }
}

class DesktopNavMenu extends StatelessWidget {
  const DesktopNavMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IntroProvider intro = context.read<IntroProvider>();
    final animation = context.read<Animation<double>>();
    return SlideAndFadeTransition(
      fade: intro.desktopNavAnimation,
      progress: animation,
      child: Container(
          color: PRIMARY,
          constraints: BoxConstraints(maxWidth: 300),
          child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: IntroNavigation(),
              ))),
    );
  }
}

class IntroNavigation extends StatelessWidget {
  const IntroNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navChildren = const [
      IntroNavButton(
        route: projectsRouteName,
        child: IntroShaderText('PROJECTS'),
      ),
      IntroNavButton(
        route: aboutMeRouteName,
        params: {'section': educationSectionName},
        child: IntroShaderText('ABOUT'),
      ),
      IntroNavButton(
        route: contactRouteName,
        child: IntroShaderText('CONTACT'),
      ),
    ];

    return context.read<Responsive>().isDesktop
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: navChildren)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: navChildren);
  }
}

class IntroShaderText extends StatelessWidget {
  final String label;
  const IntroShaderText(
    this.label, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroShaderListener(
      builder: (context, shader) => TextWithShader(
        text: label,
        style: kNavButtonTextStyle,
        shader: shader,
      ),
    );
  }
}
