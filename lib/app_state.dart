import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/route.dart';

import 'pages/projects/domain/project_model.dart';
import 'pages/projects/domain/projects_data_model.dart';
import 'utils.dart';

class AppState extends ChangeNotifier {
  // final SharedPreferences prefs;
  String initialRoute;

  bool _hasData = false;
  final hasDataKey = 'hasData';
  final loggedInKey = 'LoggedIn';
  bool isFirstLoad = true;

  int startTime;

  Project selectedProject = Project.empty();

  AppState(this.initialRoute, this.startTime, this.projectsData) {
    if (initialRoute == '/loading') initialRoute = '/';
    if (initialRoute.contains('details')) initialRoute = '/projects';

    _delaySplash();
  }

  final ProjectsDataModel projectsData;

  // List<String> projectDescriptions;

  bool get hasData => _hasData;
  set hasData(bool value) {
    _hasData = value;

    notifyListeners();
  }

  // static Future<AppState> initAppDataState() async {
  //   // final prefs = await SharedPreferences.getInstance();

  //   // final jsonString = await rootBundle.loadString('projects.json');
  //   // final jsonDecode = json.decode(jsonString);
  //   // List<Project> projects = [];
  //   // print('PRINTING PROJECT TITLES');
  //   // for (Project proj in jsonDecode) {
  //   //   projects.add(proj);
  //   //   print(proj.title);
  //   // }

  //   // final _projectsData = await ProjectsData.init();
  //   // // List<String> projDescs;
  //   // final startTime = DateTime.now().millisecondsSinceEpoch;
  //   // if (prefs.getStringList(projectDescKey) == null) {
  //   //   projDescs = await Utils.loadProjectDescriptions(prefs, jsonString);
  //   // } else {
  //   //   projDescs = await prefs.getStringList(projectDescKey) ?? [];
  //   // }

  //   final _projectsData = await ProjectsData.init();

  //   final _startTime = DateTime.now().millisecondsSinceEpoch;

  //   return AppState(Uri.base.path, _startTime, _projectsData);
  // }

  late final GoRouter router = MyRouter(this).router;

  _delaySplash() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final elapsedTime = currentTime - startTime;

    if (elapsedTime > 1000)
      hasData = true;
    else {
      await Utils.sleepMS(1000 - elapsedTime);
      hasData = true;
    }
  }
}
