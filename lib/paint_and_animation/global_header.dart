import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:provider/provider.dart';

import '../route.dart';

class GlobalHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final animation = context.read<Animation<double>>();
    return SlideTransition(
      position: Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(
          CurvedAnimation(
              curve: Interval(.7, 1, curve: Curves.easeInOutQuart),
              parent: animation)),
      child: Container(
        height: 70,
        color: PRIMARY,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: const Icon(CupertinoIcons.chevron_up),
            iconSize: 30,
            color: SECONDARY,
            tooltip: 'back',
            onPressed: () {
              // Navigator.pop(context);
              // context.pop();
              // context.goNamed(homeRouteName);
              context.goNamed(homeRouteName);
              // if (context.canPop()) {
              //   context.pop();
              // } else {

              // }
            },
          ),
          kPaddingWidgetSmall,
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Navigation',
            iconSize: 30,
            color: SECONDARY,
            onPressed: () {
              context.goNamed(navRouteName);
            },
          ),
        ]),
      ),
    );
  }
}
