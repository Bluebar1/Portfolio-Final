import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:provider/provider.dart';

import '../../responsive.dart';

class MySplashPage extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 500),
          maintainState: true,
          key: state.pageKey,
          child: LayoutBuilder(builder: (context, constraints) {
            context.read<Responsive>().screenSize = constraints;
            return const MySplashPage();
          }),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });

  const MySplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            color: PRIMARY,
          ),
        ),
        Flexible(
            child: Container(
          color: SECONDARY_DARKER,
        )),
      ],
    );
  }
}
