import 'package:flutter/material.dart';

import 'global_constants.dart';

class ProjDescThemeData {
  // The used for markdown (README.md)
  static ThemeData mdTheme = ThemeData(
      cardColor: BACKGROUND_ACCENT,
      textTheme: TextTheme(
          headline5: mdHeadline1,
          headline6: mdHeadline2,
          bodyText1: mdBodyText1,
          bodyText2: mdBodyText2,
          subtitle1: mdSubTitle1));

  static get projDescLowerGradient => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [.01, .1],
      colors: [PRIMARY, BACKGROUND_ACCENT]);

  static get projDescImageCoverGradient => LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0,
            .3,
            .6,
            1
          ],
          colors: [
            PRIMARY.withOpacity(.00),
            PRIMARY.withOpacity(.5),
            PRIMARY.withOpacity(.9),
            PRIMARY
          ]);
}

const mdHeadline1 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: SECONDARY_LIGHTER);

const mdHeadline2 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 25,
    color: SECONDARY);

const mdHeadline3 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: SECONDARY);

const mdBodyText1 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: SECONDARY);

const mdBodyText2 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: SECONDARY);

const mdBodyText3 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: SECONDARY);

const mdBodyLarge = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: SECONDARY);

const mdSubTitle1 = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: SECONDARY);
