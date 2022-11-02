import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_state.dart';
import '../../../responsive.dart';
import '../../../utils.dart';
import '../../projects/domain/project_model.dart';

class ProjDescState with ChangeNotifier {
  ScrollController controller = ScrollController();
  final AppState appState;

  ProjDescState(BuildContext context, this.appState) {
    controller.addListener(_listener);
    load(appState.selectedProject);
    _initAnimations(context);
    _initResponsive(context);
  }
  Project project = Project.empty();

  load(Project value) async {
    project = value;

    opacity = 0;
    controller = ScrollController();

    if (project.readmeText != null) return;
    // final index = appState.projectsData.
    readmeText = appState.selectedProject.readmeText!;
    // appState.projectsData.projectDescriptions[index];
    // await appState.prefs.getStringList(projectDescKey)![index];
  }

  /// Moves shadow overlay on project description screen
  double opacity = 0;
  set readmeText(String readmeText) {
    project.readmeText = readmeText;
    notifyListeners();
  }

  _listener() {
    double imageHeight = controller.position.viewportDimension / 3;
    double position = controller.position.pixels;
    if (position >= imageHeight) {
      isShowingAppBar = true;
      opacity = 1;
      notifyListeners();
      return;
    }
    isShowingAppBar = false;

    opacity = (position / imageHeight) * 2;
    if (opacity > 1)
      opacity = 1;
    else if (opacity < 0) opacity = 0;

    notifyListeners();
  }

  bool isShowingAppBar = false;

  /// Animations
  late Animation<Offset> pageAnimation;
  late Animation<double> imageAnimation, appBarAnimation;

  _initAnimations(BuildContext context) {
    final animation = context.read<Animation<double>>();
    pageAnimation = Utils.animation<Offset>(
        Offset(0, 1), Offset(0, 0), Interval(0, 1), animation);

    imageAnimation = Utils.animation<double>(0, 1, Interval(0, 1), animation);

    appBarAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: animation, curve: Interval(0.9, 1)));
  }

  /// Responsive

  late double upperHeight, lowerHeight;
  _initResponsive(BuildContext context) {
    final constraints = context.read<Responsive>().constraints;

    upperHeight = (constraints.maxHeight / 3);
    lowerHeight = upperHeight * 2;
  }
}
