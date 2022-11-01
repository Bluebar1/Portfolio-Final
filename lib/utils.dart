import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'dart:js' as js;

class Utils {
  //

  // static double paddedWidth(BuildContext context) {
  //   final width = MediaQuery.of(context).size.width;
  //   return (width > 800) ? 800 : width;
  // }

  //
  static Animatable compoundAnimation(
      {required begin, required end, required curve}) {
    return Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  }

  static dynamic animation<T>(
      dynamic begin, dynamic end, Interval interval, Animation<double> parent) {
    return Tween<T>(begin: begin, end: end)
        .animate(CurvedAnimation(curve: interval, parent: parent));
  }

  static Future<void> sleepMS(int milli) async =>
      await Future.delayed(Duration(milliseconds: milli));

  static openLink(String url) {
    js.context.callMethod('open', [url]);
  }
}

class DynamicLayout extends StatelessWidget {
  final Axis direction;
  final List<Widget> children;
  DynamicLayout({required this.direction, required this.children});
  @override
  Widget build(BuildContext context) => (direction == Axis.vertical)
      ? Column(children: children)
      : Row(children: children);
}

class Stamp {
  final String label;
  final int time;

  Stamp(this.label, this.time);
}

class DebugTimer {
  static int start = 0;
  static int end = 0;
  static List<Stamp> stamps = [];

  DebugTimer() {
    start = _now;
  }

  stamp(String label) => stamps.add(Stamp(label, _now));

  int get _now => DateTime.now().millisecond;
}
