import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../constants/global_constants.dart';
import '../domain/project_model.dart';
import '../domain/projects_domain.dart';

/// Fetch Projects data from assets and github repository.

class ProjectsData {
  static Future<String> loadProjectsJson() async =>
      await rootBundle.loadString('projects.json');

  /// Try loading the project descriptions with [SharedPreferences].
  /// If not found, fetch from github via http.
  static Future<void> loadReadmeTexts(List<Project> projects) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> _projectDescriptions;
    bool _hasData = false;
    if (prefs.getStringList(projectDescKey) == null) {
      _projectDescriptions = await fetchProjectDescriptionsHttp(projects);
      await prefs.setStringList(projectDescKey, _projectDescriptions);
    } else {
      _hasData = true;
      _projectDescriptions = await prefs.getStringList(projectDescKey) ?? [];
    }
    if (!_hasData)
      await prefs.setStringList(projectDescKey, _projectDescriptions);
    await ProjectsDomain.appendReadmeTexts(projects, _projectDescriptions);
  }

  static Future<List<String>> fetchProjectDescriptionsHttp(
      List<Project> projects) async {
    List<String> _projectDescriptions = [];
    await Future.forEach<Project>(projects, (project) async {
      final link = project.readmeLink;
      final response = await http.get(Uri.parse(link));

      String str = ProjectsDomain.removeTitleOfReadmeText(response.body);
      _projectDescriptions.add(str);
    });
    return _projectDescriptions;
  }
}
