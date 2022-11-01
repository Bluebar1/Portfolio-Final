import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_constants.dart';
import '../../../paint_and_animation/navigation_button.dart';
import '../../../route.dart';
import '../../../utils.dart';
import 'intro_state.dart';

class IntroNavButton extends StatelessWidget {
  final String route;
  final Widget child;
  final Map<String, String>? params;

  const IntroNavButton(
      {super.key, required this.child, required this.route, this.params});
  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: SlideTransition(
            position: Utils.animation<Offset>(Offset(0, 1), Offset(0, 0),
                Interval(0, 1), context.read<Animation<double>>()),
            child: NavButton(
              route: route,
              params: params ?? {},
              onPressed: _press,
              child: child,
            )));
  }

  static _press(
      BuildContext context, String route, Map<String, String> params) {
    context.read<IntroProvider>().delayedRoute(context, route, params);
  }
}

class RouteToNavButton extends StatelessWidget {
  const RouteToNavButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: IconButton(
            icon: Icon(Icons.menu),
            color: SECONDARY,
            iconSize: 30,
            onPressed: () => context
                .read<IntroProvider>()
                .delayedRoute(context, navRouteName, {})));
  }
}
