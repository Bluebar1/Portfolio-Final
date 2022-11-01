import 'package:portfolio/pages/projects/data/projects_data.dart';

import 'project_model.dart';
import 'projects_domain.dart';

/// Projects Data loaded in [AppData]

class ProjectsDataModel {
  List<Project> projects;
  // List<String> projectDescriptions;
  Map<dynamic, dynamic> quantityMap;
  List<String> allTechUsed;
  ProjectsDataModel(this.projects, this.quantityMap, this.allTechUsed);

  static Future<ProjectsDataModel> init() async {
    // Load & transform Projects from json asset file
    final _jsonString = await ProjectsData.loadProjectsJson();
    final _projects = ProjectsDomain.createProjects(_jsonString);
    final _quantityMap = ProjectsDomain.createQuantityMap(_projects);
    final _allTechUsed = ProjectsDomain.loadTechUsedLabels(_quantityMap);
    // load project descriptions
    await ProjectsData.loadReadmeTexts(_projects);
    // add descriptions to Project objects

    return ProjectsDataModel(_projects, _quantityMap, _allTechUsed);
  }
}
