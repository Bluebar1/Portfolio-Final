import 'package:flutter/material.dart';

const githubLink = 'https://github.com/Bluebar1';
const linkedInLink = 'https://www.linkedin.com/in/nick-b-a71b23249/';
const mailtoLink = 'mailto:nickblaauboer7@gmail.com';
const email = 'nickblaauboer7@gmail.com';
const projectDescKey = 'projectDescriptionsKey';

const kMaxForegroundWidth = 1000.0;
const kPrimaryRed = Color.fromRGBO(189, 68, 68, 1);

const PRIMARY = Color.fromRGBO(50, 50, 50, 1);

// const PRIMARY_ACCENT = Color.fromRGBO(43, 43, 43, 1);
const SECONDARY = Color.fromRGBO(200, 200, 200, 1);
const SECONDARY_DARKER = Color.fromRGBO(150, 150, 150, 1);
const SECONDARY_LIGHTER = Color.fromRGBO(230, 230, 230, 1);
const BACKGROUND = Color.fromRGBO(33, 33, 33, 1);
const BACKGROUND_ACCENT = Color.fromRGBO(10, 10, 10, 1);
const BACKGROUND_ACCENT2 = Color.fromRGBO(37, 37, 37, 1);

const kSpacingValue = 50.0;
const kSpacingWidget = SizedBox(height: kSpacingValue, width: kSpacingValue);

const kPageTransitionDurationMS = 1500;

const kBorderSmall = BorderRadius.all(Radius.circular(10));

const kPadding = 20.0;
const kPaddingWidget = SizedBox(width: kPadding, height: kPadding);
const kPaddingWidgetSmall = SizedBox(width: kPadding / 2, height: kPadding / 2);
const kPaddingWidgetLarge = SizedBox(width: kPadding * 2, height: kPadding * 2);

const BiggestTextSize = 35.0;
const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.5;
const SmallTextSize = 14.0;

const kForegroundMaxWidth = 900.0;

const String FontDefaultName = 'Montserrat';
const String OtherFontName = 'Sarpanch';

const DegreeTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w300,
    fontSize: MediumTextSize,
    color: SECONDARY_LIGHTER);

const kParagraphTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: BodyTextSize,
    color: SECONDARY);

const kHeaderTextStyleDark = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w500,
    fontSize: MediumTextSize,
    color: PRIMARY);

const kHeaderTextStyleLight = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w500,
    fontSize: MediumTextSize,
    color: SECONDARY);

//

const ParagraphBoldTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: BodyTextSize,
    color: SECONDARY_LIGHTER);

const LinkTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: BodyTextSize,
    color: Colors.blue);

const FilterMenuStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: SmallTextSize,
    color: SECONDARY_DARKER);

const NameTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: BiggestTextSize,
    color: SECONDARY);

const kNavButtonTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w400,
    fontSize: 80,
    color: SECONDARY);

const kStatusTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    color: SECONDARY);

//

const kProjDescTitleStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: SECONDARY);

const LanguageTextStyle = TextStyle(
    fontFamily: FontDefaultName,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    color: SECONDARY);

/// It is much harder to find community made Icons for Flutter than it is
/// for more popular popular frameworks such as React Native. To use these Icons

class MyIconData extends IconData {
  const MyIconData(int codePoint, String fontFamily)
      : super(codePoint, fontFamily: fontFamily);

  const MyIconData.antDesign(int codePoint) : this(codePoint, "AntDesign");
  const MyIconData.fontAwesome5Brands(int codePoint)
      : this(codePoint, "FontAwesome5_Brands");
}

class MyIcons {
  static const IconData github = const MyIconData.antDesign(59053);
  static const IconData java = const MyIconData.fontAwesome5Brands(62692);
  static const IconData python = const MyIconData.fontAwesome5Brands(62434);
}
