import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/pages/projects/presentation/projects_state.dart';
import 'package:portfolio/paint_and_animation/compound_animations.dart';
import 'package:portfolio/paint_and_animation/global_header.dart';
import 'package:portfolio/responsive.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import 'presentation/project_tile.dart';
import 'presentation/projects_modules.dart';

class Projects extends StatelessWidget {
  static Page<void> builder(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<void>(
        transitionDuration: Duration(milliseconds: 1000),
        key: state.pageKey,
        maintainState: true,
        child: ChangeNotifierProvider<ProjectsState>(
          lazy: false,
          create: (context) => ProjectsState(context),
          child: LayoutBuilder(builder: (context, constraints) {
            print(DateTime.now().millisecondsSinceEpoch);
            print('layout building');
            context.read<Responsive>().screenSize = constraints;
            context.read<ProjectsState>().setGridPadding(constraints);
            // final pageState = context.read<ProjectsState>();
            // pageState.setGridPadding(constraints);
            // pageState.loadProjects();
            return const Projects();
          }),
        ),
        transitionsBuilder: (context, animation, _, child) {
          return ListenableProvider.value(
              builder: (context, _) => child, value: animation);
        });
  }

  const Projects();

  @override
  Widget build(BuildContext context) {
    print('projects rebuilding');
    final pageData = context.read<ProjectsState>();

    final _children = [
      ProjectsSection(child: ProjectsIntro(), fade: pageData.headerAnimation),
      ProjectsSection(child: MostUsedTech(), fade: pageData.techMenuAnimation),
      ProjectsSection(child: FilterMenu(), fade: pageData.techMenuAnimation),
      ProjectsSection(
          child: CurrentlyShowing(), fade: pageData.techMenuAnimation),
      ProjectsGrid(),
    ];

    return FadeTransition(
        opacity: pageData.backgroundOpacityAnimation,
        child: Scaffold(
            backgroundColor: BACKGROUND,
            body: SafeArea(
                child: Stack(children: [
              CustomScrollView(
                slivers: _children,
                shrinkWrap: true,
              ),
              GlobalHeader()
            ]))));
  }
}

@immutable
class ProjectsSection extends StatelessWidget {
  final Widget child;

  final Animatable<dynamic> fade;
  const ProjectsSection({Key? key, required this.child, required this.fade})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = context.read<Animation<double>>();
    return SliverToBoxAdapter(
      child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kMaxForegroundWidth),
              child: SlideAndFadeTransition(
                  fade: fade, progress: progress, child: child))),
    );
  }
}

class ProjectsGrid extends StatelessWidget {
  ProjectsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    print('PROJECTS GRID REBUILDING');
    context.select((ProjectsState p) => p.filterIndex);
    final padding = context.select((ProjectsState p) => p.gridPadding);
    final projects = context.read<ProjectsState>().filteredProjects;
    final _innerList = List.generate(
        projects.length,
        (index) => Hero(
              tag: projects[index].title.toString(),
              child: ProjectGridTile(
                  project: projects[index], type: GridType.small),
            ));
    final pageData = context.read<ProjectsState>();
    final resp = context.read<Responsive>();
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: padding),

      // padding: EdgeInsets.symmetric(
      //     horizontal:
      //         resp.isDesktop ? (kMaxForegroundWidth - resp.maxWidth) / 2 : 0),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 375,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => FadeTransition(
              opacity: pageData.gridTileAnimation, child: _innerList[index]),
          childCount: projects.length,
        ),
      ),
    );
  }
}
