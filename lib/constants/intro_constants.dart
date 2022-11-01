import 'package:flutter/material.dart';

const NAME = ['NICHOLAS', 'BLAAUBOER'];
const DEGREETEXT = [
  'University at Albany',
  'B.A. in Computer Science',
  'Minors in Mathematics\nand Informatics '
];

const kIntroString = '';
const kIntroAnimationCurve = Curves.linear;
const kSideMenuWidth = 300.0;

class IntroThemeData {
  static get demoButtonBoxDecoration => BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black,
            offset: Offset(3, 3),
            blurRadius: 12,
            spreadRadius: 1),
        BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: Offset(-3, -3),
            blurRadius: 12,
            spreadRadius: .1)
      ]);
}
