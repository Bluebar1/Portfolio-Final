import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:provider/provider.dart';

import '../../paint_and_animation/compound_animations.dart';
import '../../paint_and_animation/navigation_button.dart';
import '../../responsive.dart';
import '../../route.dart';
import '../../constants/about_me_constants.dart';
import 'presentation/about_me_state.dart';

class AboutMe extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 1000),
          maintainState: true,
          key: state.pageKey,
          child: Provider<AboutMeData>(
            lazy: false,
            create: (BuildContext context) => AboutMeData(context),
            child: LayoutBuilder(builder: (context, constraints) {
              context.read<Responsive>().screenSize = constraints;
              return AboutMe(
                  section: state.params.isNotEmpty
                      ? state.params['section']!
                      : educationSectionName);
            }),
          ),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });

  final String section;

  const AboutMe({required this.section});
  @override
  Widget build(BuildContext context) {
    AboutMeSectionData data;
    switch (section) {
      case educationSectionName:
        data = AboutMeSectionData.education();
        break;
      case workHistorySectionName:
        data = AboutMeSectionData.workHistory();
        break;
      case recentPublicationsSectionsName:
        data = AboutMeSectionData.recentPublications();
        break;
      default:
        data = AboutMeSectionData.education();
    }

    final animation = context.read<Animation<double>>();

    void _pressed() => (data.nextRoute == null)
        ? context.pushNamed(homeRouteName)
        : context.pushNamed(aboutMeRouteName, params: data.nextRoute!);

    void _pop() => (context.canPop())
        ? context.pop()
        : (data.prevRoute == null)
            ? context.pushNamed(homeRouteName)
            : context.pushNamed(aboutMeRouteName, params: data.prevRoute!);
    final pageData = context.read<AboutMeData>();
    final resp = context.read<Responsive>();
    print('rebuilding about me');
    return SlideTransition(
      position: pageData.pageAnimation,
      child: Scaffold(
        backgroundColor: SECONDARY,
        body: SafeArea(
          child: Center(
            child: Container(
              child: FadePositionScaleTransition(
                fade: pageData.boxAnimation,
                progress: animation,
                child: ListView(
                  padding: resp.sliverPadding,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: data.color,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              textAlign: TextAlign.center,
                              section.replaceAll('_', ' '),
                              style: NameTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 55,
                                color: PRIMARY,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(5.0, 5.0),
                                    blurRadius: 3.0,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: BACKGROUND,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      child: ExperienceListModule(
                          icon: data.icon!, data: data.data!),
                    ),
                    kPaddingWidget,
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NavButton(
                              label: data.prevString,
                              route: contactRouteName,
                              params: data.prevRoute,
                              color: PRIMARY,
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                              fontSize: 45,
                              onPressedVoid: _pop,
                            ),
                            SizedBox(width: 100),
                            NavButton(
                              label: data.nextString,
                              route: contactRouteName,
                              params: data.nextRoute,
                              color: PRIMARY,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                              fontSize: 45,
                              onPressedVoid: _pressed,
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExperienceListModule extends StatelessWidget {
  final IconData icon;
  final Map<String, List<String>> data;

  const ExperienceListModule({
    Key? key,
    required this.icon,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var achievements;

    var category;
    final pageData = context.read<AboutMeData>();
    return Padding(
      padding: EdgeInsets.all(15),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AboutMeHeader(
                icon: icon, verticalBarSize: pageData.verticalBarSize),
            Flexible(
              flex: 7,
              child: Container(
                padding: EdgeInsets.only(top: 60, bottom: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(data.length, (categoryIndex) {
                      category = data.keys.elementAt(categoryIndex);
                      achievements = data[category];

                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizeTransition(
                                axis: Axis.horizontal,
                                axisAlignment: 0,
                                sizeFactor: pageData.sectionBodyTextSize,
                                child: Text(category,
                                    style: ParagraphBoldTextStyle)),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      achievements.length,
                                      (index) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("\u2022",
                                                    style: kParagraphTextStyle),
                                                SizedBox(width: 5),
                                                Flexible(
                                                  child: SizeTransition(
                                                    axis: Axis.horizontal,
                                                    axisAlignment: 0,
                                                    sizeFactor: pageData
                                                        .sectionHeaderTextSize,
                                                    child: Text(
                                                        achievements[index],
                                                        style:
                                                            kParagraphTextStyle),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutMeHeader extends StatelessWidget {
  const AboutMeHeader({
    Key? key,
    required this.icon,
    required verticalBarSize,
  })  : _verticalBarSize = verticalBarSize,
        super(key: key);

  final IconData icon;
  final _verticalBarSize;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: SECONDARY, size: 60),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SizeTransition(
                  axis: Axis.vertical,
                  axisAlignment: 1,
                  sizeFactor: _verticalBarSize,
                  child: Center(
                    child: Container(
                      color: SECONDARY,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
