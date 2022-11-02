import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:portfolio/pages/projects/domain/project_model.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';
import '../../constants/proj_desc_constants.dart';
import '../../responsive.dart';
import '../projects/presentation/project_tile.dart';
import 'presentation/proj_desc_modules.dart';
import 'presentation/proj_desc_state.dart';

class ProjDesc extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 500),
          maintainState: true,
          key: state.pageKey,
          child: ChangeNotifierProvider<ProjDescState>(
            lazy: false,
            create: (context) =>
                ProjDescState(context, context.read<AppState>()),
            child: LayoutBuilder(builder: (context, constraints) {
              context.read<Responsive>().screenSize = constraints;

              return const ProjDesc();
            }),
          ),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });

  const ProjDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageData = context.read<ProjDescState>();
    final Project project = pageData.project;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // image background
          Positioned.fill(
              child: FadeTransition(
                  opacity: pageData.imageAnimation,
                  child: Container(color: PRIMARY))),
          Column(
            children: [
              Flexible(
                flex: 1,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: kMaxForegroundWidth),
                  child: Hero(
                    tag: project.title.toString(),
                    child: ProjectGridTile(
                      project: project,
                      type: GridType.large,
                    ),
                  ),
                ),
              ),
              Flexible(flex: 2, child: Container())
            ],
          ),
          Positioned.fill(
            child: SlideTransition(
              position: pageData.pageAnimation,
              child: ListView(
                children: [
                  AnimatedOpacityImageOverlay(
                      project: project, height: pageData.upperHeight),
                  ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: pageData.lowerHeight),
                      child: Container(
                          child: Column(
                            children: [MarkdownData(), Container(height: 1000)],
                          ),
                          decoration: BoxDecoration(
                              gradient:
                                  ProjDescThemeData.projDescLowerGradient))),
                ],
              ),
            ),
          ),
          FadeTransition(
              opacity: pageData.appBarAnimation,
              child: ProjDescAppBar(project: project))
        ],
      ),
    );
  }
}
