import 'package:flutter/material.dart';

import 'constants/global_constants.dart';

const kDesktopBreakpoint = 1500;
const kMobileBreakpoint = 600;
const kMobileHeight = 500;

/// [desktop] =
///   [AppState.maxWidth] > [kDesktopBreakpoint]
///   &&
///   [AppState.aspect] > 1
///
/// [tablet] =
///   [AppState.maxWidth] > [kMobileBreakpoint]
///
///
/// [mobile] =
///   [AppState.maxWidth] < [kMobileBreakpoint]
///
///
enum ScreenType { desktop, mobile, tablet }

class Responsive {
  BoxConstraints constraints = BoxConstraints();
  ScreenType screenType = ScreenType.desktop;

  set screenSize(BoxConstraints con) {
    this.constraints = con;

    screenType = (maxWidth > kDesktopBreakpoint) && (aspect > 1)
        ? ScreenType.desktop
        : maxWidth > kMobileBreakpoint && aspect > 1
            ? ScreenType.tablet
            : ScreenType.mobile;

    final width = constraints.maxWidth;
    double _horizontal;
    if (width < kMaxForegroundWidth)
      _horizontal = 0;
    else
      _horizontal = (width - kMaxForegroundWidth) / 2;

    sliverPadding = EdgeInsets.fromLTRB(_horizontal, 20, _horizontal, 100);
  }

  EdgeInsets _sliverPadding = EdgeInsets.zero;
  EdgeInsets get sliverPadding => _sliverPadding;
  set sliverPadding(EdgeInsets sp) {
    _sliverPadding = sp;
    // notifyListeners();
  }

  // late Animation<double> pageAnimation;

  // EdgeInsets sliverPadding = EdgeInsets.zero;
  // set padding(BuildContext context) {
  //   final width = constraints.maxWidth;
  //   double _horizontal;
  //   if (width < 800)
  //     _horizontal = 0;
  //   else
  //     _horizontal = (width - 800) / 2;

  //   sliverPadding = EdgeInsets.fromLTRB(_horizontal, 20, _horizontal, 100);
  // }

  bool get isDesktop => screenType == ScreenType.desktop;
  bool get isTablet => screenType == ScreenType.tablet;
  bool get isMobile => screenType == ScreenType.mobile;
  double get maxWidth => constraints.maxWidth;
  double get maxHeight => constraints.maxHeight;
  double get aspect => maxWidth / maxHeight;
}
