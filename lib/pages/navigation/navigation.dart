import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';

import 'package:provider/provider.dart';

import '../../responsive.dart';
import 'presentation/navigation_state.dart';
import 'presentation/navigation_modules.dart';

class Navigation extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 1000),
          maintainState: true,
          key: state.pageKey,
          child: Provider<NavigationData>(
            lazy: false,
            create: (context) => NavigationData(context),
            child: LayoutBuilder(builder: (context, constraints) {
              context.read<Responsive>().screenSize = constraints;
              return const Navigation();
            }),
          ),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });
  const Navigation();
  @override
  Widget build(BuildContext context) {
    final pageData = context.read<NavigationData>();

    return SlideTransition(
      position: pageData.pageAnimation,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(189, 68, 68, 1),
              BACKGROUND_ACCENT2
            ])),
            child: const NavScreenButtons(),
          ),
        ),
      ),
    );
  }
}
