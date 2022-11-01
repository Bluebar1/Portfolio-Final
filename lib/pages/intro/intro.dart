import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/pages/intro/presentation/intro_state.dart';
import 'package:portfolio/responsive.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../paint_and_animation/painters.dart';
import '../../route.dart';
import 'presentation/intro_responsive.dart';

class IntroPage extends StatefulWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) {
    final intro = context.read<IntroProvider>();
    intro.precacheImages(context);

    return CustomTransitionPage<void>(
        transitionDuration: Duration(milliseconds: 1000),
        maintainState: true,
        key: state.pageKey,
        child: LayoutBuilder(builder: (context, constraints) {
          context.read<Responsive>().screenSize = constraints;
          return IntroPage(intro);
        }),
        transitionsBuilder: (context, animation, _, child) {
          return ListenableProvider.value(
              builder: (context, _) => child, value: animation);
        });
  }

  final IntroProvider intro;
  const IntroPage(this.intro);
  @override
  State<IntroPage> createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> pageAnimation;
  IntroProvider get intro => widget.intro;
  @override
  void initState() {
    super.initState();

    intro.driveController(this);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.read<Responsive>();
    return SlideTransition(
      position: intro.pageAnim.animate(context.read<Animation<double>>()),
      child: Scaffold(
          body: SafeArea(
              child: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dy < 0)
            intro.delayedRoute(context, projectsRouteName, {});
        },
        child: Container(
            color: BACKGROUND,
            child: Stack(fit: StackFit.expand, children: [
              CustomPaint(painter: BackgroundCirclePainter()),
              introResponsiveMap[responsive.screenType]!,
              // if (intro.isFirstLoad) SplashFadeAway()
            ])),
      ))),
    );
  }
}
