import 'package:flutter/material.dart';

import '../route.dart';

const kEducationInformation = {
  'Christian Brothers Academy high school (2017)': [
    'Recieved Rochester Institute of Technology (RIT) Computing Medal and Scholarship',
    'Activities: Drums in school band, lacrosse team.'
  ],
  'University at Albany SUNY (2021)': [
    'B.A. in Computer Science. Minors in Mathematics and Informatics ',
    'Undergraduate research on how masks affect common facial recognition algorithms.',
  ]
};

const kWorkHistoryInfo = {
  'EndercraftBuild (2013-inactive)': [
    'Co-Owner of ECB Minecraft Network and github repository.',
    'Administrated active server of over 100,000 unique players.',
    'Contributed to large-scale Java codebases (15,000+ lines).',
  ],
  'Bellini\'s Loudonville (2015-2022)': [
    'As a student in highschool and college I worked as a cook at Bellini\'s Italian Eatery.'
  ],
  'Diamond4Mobile LLC (2020-2022)': [
    'Implemented Rest API calls to wikipedia in Swift, searching for pages using GPS data.',
    'Ported basic features of the PhotoGem App from Swift to Flutter.',
    'Built PhotoGem website and help page using HTML/CSS/JavaScript.',
    'Currently looking for solution to iOS SQLite issue in Swift codebase.'
  ],
};

const kRecentPublishedWork = {
  'Dynamic Web Scrolling pub.dev package': [
    'Brings smooth scrolling for pointers (scrollwheel) to all Flutter platforms.',
    'Adjust the values to your liking.',
    'Automatically handles wrong detections of mobile or desktop device.',
  ],
  'Grapher pub.dev package': [
    'Takes any function string such as "x*30+100" and displays it on a graph',
  ],
  'Face Detection university research': [
    'Uses multiple face detection algorithms to analyze how masks affect their ability to detect faces.'
  ]
};

class AboutMeSectionData {
  Map<String, List<String>>? data;
  Map<String, String>? nextRoute;
  Map<String, String>? prevRoute;
  String? nextString;
  String? prevString;
  Color? color;
  IconData? icon;

  // AboutMeData() {

  // }

  AboutMeSectionData.education() {
    data = kEducationInformation;
    nextRoute = {'section': workHistorySectionName};
    prevRoute = null;
    color = Colors.redAccent;
    icon = Icons.school;
    nextString = 'Work History >';
    prevString = '< Back Home';
  }

  AboutMeSectionData.workHistory() {
    data = kWorkHistoryInfo;
    nextRoute = {'section': recentPublicationsSectionsName};
    prevRoute = {'section': educationSectionName};
    color = Colors.blueAccent;
    icon = Icons.badge;
    nextString = 'Publications >';
    prevString = '< Education';
  }

  AboutMeSectionData.recentPublications() {
    data = kRecentPublishedWork;
    color = Colors.amberAccent;
    icon = Icons.library_books;
    nextString = 'Back Home >';
    prevRoute = {'section': workHistorySectionName};
    prevString = '< Work History';
  }
}
