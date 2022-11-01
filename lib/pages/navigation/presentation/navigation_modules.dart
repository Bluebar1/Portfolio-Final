import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../paint_and_animation/navigation_button.dart';
import '../../../route.dart';
import 'navigation_state.dart';

class FadeInNavButton extends StatelessWidget {
  final String label;
  final String route;
  final Map<String, String>? params;
  const FadeInNavButton(
      {super.key, required this.label, required this.route, this.params});
  @override
  Widget build(BuildContext context) {
    final pageData = context.read<NavigationData>();
    return ClipRect(
        child: SlideTransition(
      position: pageData.navButtonsAnimation,
      child: NavButton(label: label, route: route, params: params ?? {}),
    ));
  }
}

class NavScreenButtons extends StatelessWidget {
  const NavScreenButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const FadeInNavButton(
            label: 'HOME',
            route: homeRouteName,
          ),
          const FadeInNavButton(
            label: 'PORTFOLIO',
            route: projectsRouteName,
          ),
          const FadeInNavButton(
            label: 'ABOUT ME',
            route: aboutMeRouteName,
            params: {'section': educationSectionName},
          ),
          const FadeInNavButton(
            label: 'CONTACT',
            route: contactRouteName,
          ),
        ]),
      ),
    );
  }
}
