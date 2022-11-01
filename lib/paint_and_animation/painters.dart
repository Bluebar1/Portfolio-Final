import 'package:flutter/material.dart';
import 'package:portfolio/constants/global_constants.dart';

class AnimatedBorderPainter extends CustomPainter {
  final Animation<double> animation;
  // double value = 0;
  String? label;
  final Color color;
  AnimatedBorderPainter(this.animation, {required this.color, this.label})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..strokeWidth = 2;
    canvas.drawLine(Offset(0, size.height),
        Offset(size.width * animation.value, size.height), paint);
    canvas.drawLine(
        Offset(size.width, size.height),
        Offset(size.width, size.height - (size.height * animation.value)),
        paint);
    canvas.drawLine(Offset(size.width, 0),
        Offset(size.width - (size.width * animation.value), 0), paint);
    canvas.drawLine(
        Offset(0, 0), Offset(0, size.height * animation.value), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class MyTextPainter extends CustomPainter {
  final Color color;
  final String text;

  MyTextPainter(this.color, this.text);
  @override
  void paint(Canvas canvas, Size size) {
    TextPainter tp = TextPainter(
        text: TextSpan(
            style: kStatusTextStyle.copyWith(color: color, fontSize: 40),
            text: text),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(-(tp.width / 2), -10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BackgroundCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = PRIMARY.withOpacity(.3)
      ..style = PaintingStyle.fill;
    final radius =
        (size.width > size.height) ? size.width / 2 : size.height / 2;
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawCircle(Offset(size.width / 2, 0), radius * .7, paint1);
    canvas.drawCircle(Offset(size.width / 2, 0), radius * .8, paint1);
    canvas.drawCircle(Offset(size.width / 2, 0), radius * .9, paint1);
    canvas.drawCircle(Offset(size.width / 2, 0), radius, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DividerPainter extends CustomPainter {
  final Paint _paint = Paint()
    ..style = PaintingStyle.fill
    ..color = SECONDARY_LIGHTER
    ..strokeWidth = 2;

  final bool LTR;

  DividerPainter(this.LTR);

  @override
  void paint(Canvas canvas, Size size) {
    double leftY = LTR ? 0 : size.height;
    double rightY = LTR ? size.height : 0;

    canvas.drawLine(Offset(0, leftY), Offset(size.width - 50, leftY), _paint);
    canvas.drawLine(Offset(50, rightY), Offset(size.width, rightY), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class BorderPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double radius = 12;
  final double strokeWidth = 10;
  final Shader shader;

  BorderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    _paint.shader = shader;

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}
