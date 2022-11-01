import 'dart:collection';
import 'dart:convert';

import 'project_model.dart';

/// Convert raw Projects data into usable objects
///

class ProjectsDomain {
  static List<Project> createProjects(String jsonString) {
    List<Project> f = [];

    // final String js = await rootBundle.loadString('projects.json');
    final List my_data = json.decode(jsonString);

    for (var proj in my_data) {
      f.add(Project(
        proj['title'],
        proj['technologyUsed'],
        proj['details'],
        proj['githubLink'],
        proj['readmeLink'],
        'img/${proj['image']}',
      ));
    }
    return f;
  }

  static Future<void> appendReadmeTexts(
      List<Project> projects, List<String> projectDescriptions) async {
    int i = 0;

    await Future.forEach<Project>(projects, (project) async {
      project.readmeText = projectDescriptions[i++];
    });
    return;
  }

  static List<String> loadTechUsedLabels(Map quantityMap) =>
      quantityMap.entries.map((e) => '${e.key} (${e.value})').toList();

  static Map createQuantityMap(List<Project> allProjects) {
    Map _quantityMap = {};
    _quantityMap.putIfAbsent('All', () => allProjects.length);
    for (Project p in allProjects) {
      for (String t in p.technologyUsed!) {
        _quantityMap.update(t, (value) => ++value, ifAbsent: () => 1);
      }
    }

    var sortedKeys = _quantityMap.keys.toList(growable: false)
      ..sort((k2, k1) => _quantityMap[k1].compareTo(_quantityMap[k2]));

    LinkedHashMap sortedHashMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => _quantityMap[k]);

    _quantityMap = new Map.from(sortedHashMap);
    return _quantityMap;
  }

  static String removeTitleOfReadmeText(String readmeText) {
    List<RegExpMatch> matches = RegExp(r'^#.+').allMatches(readmeText).toList();
    for (RegExpMatch m in matches)
      readmeText = readmeText.replaceRange(m.start, m.end, '');

    return readmeText;
  }
}
