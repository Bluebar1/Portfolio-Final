import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';
import '../../../responsive.dart';
import '../../../paint_and_animation/compound_animations.dart';
import '../../../utils.dart';

const kFit = BoxFit.cover;

class IntroProvider with ChangeNotifier {
  final AppState dataState;
  bool get isFirstLoad => dataState.isFirstLoad;
  IntroProvider(this.dataState) {
    initAnim();
    initImages();
  }

  /// 8-second-long infinite animation created in [IntroPageState]
  AnimationController? controller;

  late Image portrait, github, wikimap, grapher, splash;
  late final Animatable textAnimation,
      picAnimation,
      demoGridAnimation,
      desktopNavAnimation;
  late final Animatable<Offset> pageAnim;
  initImages() {
    portrait = Image.asset('img/profile_pic.PNG', fit: kFit);
    github = Image.asset('img/gitcap.PNG', fit: kFit);
    wikimap = Image.asset('img/wikimapdemo.PNG', fit: kFit);
    grapher = Image.asset('img/scrolldemo.PNG', fit: kFit);
    splash = Image.asset('img/splash.PNG', fit: kFit);
  }

  initAnim() {
    pageAnim = Tween(begin: Offset(0, -1), end: Offset(0, 0))
        .chain(CurveTween(curve: Interval(0, .5, curve: Curves.easeInOutCirc)));
    desktopNavAnimation = Utils.compoundAnimation(
        begin: const FadePosition(0.0, Offset(-300, 0)),
        end: const FadePosition(1.0, Offset(0, 0)),
        curve: Interval(.5, 1));
    demoGridAnimation = Utils.compoundAnimation(
        begin: const FadePosition(0.0, Offset(300, 0)),
        end: const FadePosition(1.0, Offset(0, 0)),
        curve: Interval(.5, 1));
    picAnimation = Utils.compoundAnimation(
        begin: const FadePositionScale(FadePosition(0, Offset(30, 30)), .9),
        end: const FadePositionScale(FadePosition(1, Offset(0, 0)), 1.0),
        curve: Interval(.5, .7));

    textAnimation = Utils.compoundAnimation(
        begin: const FadePositionScale(FadePosition(0, Offset(-30, 30)), .9),
        end: const FadePositionScale(FadePosition(1, Offset(0, 0)), 1.0),
        curve: Interval(.5, .7));
  }

  precacheImages(BuildContext context) {
    precacheImage(portrait.image, context);
    if (context.read<Responsive>().isDesktop) {
      precacheImage(github.image, context);
      precacheImage(wikimap.image, context);
      precacheImage(grapher.image, context);
      precacheImage(splash.image, context);
    }
  }

  driveController(TickerProvider vsync) async {
    isFading = false;

    controller = AnimationController(
      duration: Duration(seconds: 8),
      vsync: vsync,
    );
    await Utils.sleepMS(isFirstLoad ? 1200 : 30);
    controller!.repeat(reverse: true, period: Duration(seconds: 8));
  }

  // @override
  // dispose() {
  //   print('STATE DISPOSE METHOD CALLED');
  //   controller!.dispose();
  //   super.dispose();
  // }

  /// Disables color gradient animation when fading in [IntroShaderListener]
  /// Set to true in [delayedRoute], giving the page time to play its reverse
  /// animation.
  bool isFading = false;
  delayedRoute(
      BuildContext context, String route, Map<String, String> params) async {
    isFading = true;
    notifyListeners();
    await controller!.animateTo(0, duration: Duration(milliseconds: 10));
    await controller!.animateTo(0,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
    controller!.dispose();
    context.goNamed(route, params: params);
  }
}
