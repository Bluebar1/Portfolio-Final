import 'package:flutter/material.dart';
import 'package:portfolio/utils.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';
import '../../../constants/global_constants.dart';
import '../../../paint_and_animation/compound_animations.dart';
import '../domain/project_model.dart';
import 'projects_modules.dart';

class ProjectsState with ChangeNotifier {
  // final ProjectsData projectsData;
  ProjectsState(BuildContext context) {
    // print('proj state constructor');
    // filteredProjects = [Project.empty()];
    // loadProjects();
    final projectsData = context.read<AppState>().projectsData;
    allProjects = [...projectsData.projects];
    filteredProjects = [...allProjects];
    allTechUsed = [...projectsData.allTechUsed];
    quantityMap = {...projectsData.quantityMap};
    _initAnimations(context);
  }

  /// State

  /// Hold data for all projects, used to fill [_filteredProjects]
  /// when [_filterIndex] changes.
  List<Project> allProjects = [];

  /// Display projects with given [filterIndex].
  /// Initially all projects are displayed.
  List<Project> filteredProjects = [];

  /// What technology is being filtered, initialized as 0 (All).
  int filterIndex = 0;

  /// Hold data for technology used in Label/Quantity format (e.g. "Dart (4)").
  /// Used by [FilterMenu] to access labels given [_filterIndex].
  List<String> allTechUsed = [];

  /// Store (Label,Quantity)'s in Map format in descending order
  Map quantityMap = {};
  // double lastPaddingUpdate = 0;
  double _gridPadding = 0;
  double get gridPadding => _gridPadding;

  double oldPadding = 0;
  double oldWidth = 0;
  setGridPadding(BoxConstraints constraints) async {
    final width = constraints.maxWidth;
    double _horizontal;
    if (width < kMaxForegroundWidth)
      _horizontal = 0;
    else
      _horizontal = (width - kMaxForegroundWidth) / 2;

    await Utils.sleepMS(10);
    _gridPadding = _horizontal.roundToDouble();
    // if ((_gridPadding - oldPadding).abs() > 10) {
    //   notifyListeners();
    // }
    // oldPadding = _gridPadding;
    print('grid padding: $_gridPadding');

    notifyListeners();
  }

  /// Clear [_filteredProjects] and sleep for re-animation.
  /// Refill [_filteredProjects] with matching projects
  /// Update [_filterIndex] to display white border in [FilterMenu]
  applyFilter(int index) async {
    String tech = quantityMap.keys.elementAt(index);
    filteredProjects.clear();
    notifyListeners();

    await Utils.sleepMS(50);

    allProjects.forEach((element) {
      if (tech == 'All' || element.technologyUsed!.contains(tech)) {
        filteredProjects.add(element);
      }
    });
    filterIndex = index;

    notifyListeners();
  }

  String get label => quantityMap.keys.elementAt(filterIndex);

  /// Animations

  late Animatable<FadePosition> headerAnimation,
      techMenuAnimation,
      projectsGridAnimation;

  late Animation<double> backgroundOpacityAnimation, gridTileAnimation;
  _initAnimations(BuildContext context) {
    final animation = context.read<Animation<double>>();
    headerAnimation = Tween<FadePosition>(
            begin: const FadePosition(0.0, Offset(40, 10)),
            end: const FadePosition(1.0, Offset(0, 0)))
        .chain(CurveTween(curve: Interval(.5, .9)));

    techMenuAnimation = Tween<FadePosition>(
            begin: const FadePosition(0.0, Offset(40, 10)),
            end: const FadePosition(1.0, Offset(0, 0)))
        .chain(CurveTween(curve: Interval(.6, .9)));

    projectsGridAnimation = Tween<FadePosition>(
            begin: const FadePosition(0.0, Offset(0, 100)),
            end: const FadePosition(1.0, Offset(0, 0)))
        .chain(CurveTween(curve: Interval(.8, 1)));

    backgroundOpacityAnimation =
        Utils.animation<double>(0, 1, Interval(0, .4), animation);

    gridTileAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animation, curve: Interval(.5, 1, curve: Curves.easeInCubic)));
  }

  // loadProjects() async {
  //   print('LOADING PROJECTS');
  //   allProjects = await ProjectsServices.loadProjects();
  //   quantityMap = ProjectsServices.loadTechUsed(allProjects);
  //   allTechUsed =
  //       quantityMap.entries.map((e) => '${e.key} (${e.value})').toList();
  //   filteredProjects = [...allProjects];
  //   print('done loading projects');
  //   notifyListeners();
  // }

}
