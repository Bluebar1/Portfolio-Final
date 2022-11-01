import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../responsive.dart';

class ErrorPage extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 500),
          maintainState: true,
          key: state.pageKey,
          child: LayoutBuilder(builder: (context, constraints) {
            context.read<Responsive>().screenSize = constraints;
            return const ErrorPage();
          }),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });

  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final animation = context.read<Animation<double>>();
    final Tween<Offset> slideAnimation =
        Tween(begin: Offset(1, 0), end: Offset(0, 0));
    return SlideTransition(
      position: slideAnimation.animate(animation),
      child: Scaffold(
          backgroundColor: PRIMARY,
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Page not found',
                style: kStatusTextStyle,
              ),
              Text(
                'Redirecting to home page',
                style: kStatusTextStyle.copyWith(
                    fontSize: 23, color: SECONDARY.withOpacity(.6)),
              ),
            ],
          ))),
    );
  }
}
