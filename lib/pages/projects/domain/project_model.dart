import 'package:flutter/material.dart';

class Project {
  final String? title;
  final List<dynamic>? technologyUsed;
  final String? details;
  final String? githubLink;
  final String readmeLink;
  String? readmeText;
  Image? image;
  final String imgPath;
  // final DecorationImage? imgData;

  Project(this.title, this.technologyUsed, this.details, this.githubLink,
      this.readmeLink, this.imgPath) {
    image = Image.asset(imgPath);
  }

  Project.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        technologyUsed = json['technologyUsed'],
        details = json['details'],
        githubLink = json['githubLink'],
        readmeLink = json['readmeLink'],
        imgPath = json['img'];

  Project.empty()
      : title = "",
        technologyUsed = ['empty'],
        details = "",
        githubLink = "",
        readmeLink = "",
        imgPath = "";
}
