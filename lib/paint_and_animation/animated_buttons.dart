import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/global_constants.dart';
import 'package:portfolio/paint_and_animation/painters.dart';
import 'package:portfolio/utils.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class NavButtonState with ChangeNotifier {}

class AnimatedBorderTextButton extends StatefulWidget {
  // final String label;
  final String? route;
  final Map<String, String>? params;
  final double fontSize;
  // final TextStyle? style;
  final Widget? child;
  final String? label;
  final EdgeInsets padding;
  // final bool hasColorGradient;
  final Color borderColor;
  final Function()? onPressed;
  final Function(BuildContext, String, Map<String, String>)? delayedRoute;

  AnimatedBorderTextButton({
    super.key,
    this.child,
    this.label,
    this.route,
    this.params,
    this.fontSize = 80,
    this.borderColor = SECONDARY_LIGHTER,
    this.delayedRoute,
    this.onPressed,
    this.padding = const EdgeInsets.all(50),
  });

  @override
  AnimatedBorderTextButtonState createState() =>
      AnimatedBorderTextButtonState();
}

class AnimatedBorderTextButtonState extends State<AnimatedBorderTextButton>
    with SingleTickerProviderStateMixin {
  bool hover = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          controller.forward();
        },
        onExit: (event) => controller.reverse(),
        child: GestureDetector(
          onTap: () {
            if (widget.delayedRoute != null) {
              widget.delayedRoute!(context, widget.route!, widget.params ?? {});
            } else if (widget.onPressed != null) {
              widget.onPressed!();
            } else {
              context.goNamed(widget.route!, params: widget.params ?? {});
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: RepaintBoundary(
                child: CustomPaint(
                    painter: AnimatedBorderPainter(controller,
                        color: widget.borderColor)),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.child ??
                    Text(widget.label ?? 'no label or child found',
                        style: kNavButtonTextStyle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconAndTextButton extends StatefulWidget {
  final IconData icon;
  // final Size size;

  final Image image;

  final String label;
  final double bottomPadding;

  Interval? interval;
  Color color;
  String link;

  IconAndTextButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.interval,
    required this.image,
    required this.link,
    this.bottomPadding = 0,
    this.color = SECONDARY,
  }) : super(key: key);

  @override
  IconAndTextButtonState createState() => IconAndTextButtonState();
}

class IconAndTextButtonState extends State<IconAndTextButton>
    with SingleTickerProviderStateMixin {
  bool hover = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => hover = true),
      onExit: (event) => setState(() => hover = false),
      child: GestureDetector(
        onTap: () {
          Utils.openLink(widget.link);
          context.read<AppState>().isFirstLoad = false;
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            widget.image,
            Positioned(
              child: LayoutBuilder(builder: (context, constraints) {
                return Stack(children: [
                  Positioned(
                    right: 0,
                    child: AnimatedContainer(
                      curve: Interval(0, 1, curve: Curves.easeInOutCubic),
                      duration: Duration(milliseconds: 400),
                      height: constraints.maxHeight,
                      width: (hover) ? constraints.maxWidth : 0,
                      decoration: BoxDecoration(color: Colors.redAccent),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: AnimatedContainer(
                      curve: Interval(.2, 1, curve: Curves.easeInOutSine),
                      duration: Duration(milliseconds: 400),
                      height: constraints.maxHeight,
                      width: (hover) ? constraints.maxWidth : 0,
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  ),
                ]);
              }),
            ),
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: hover ? 1 : 0,
                curve: Interval(.2, .5, curve: Curves.easeInOutCubic),
                duration: Duration(milliseconds: 500),
                child: Center(
                    child: Text(
                  widget.label,
                  style: kStatusTextStyle.copyWith(color: PRIMARY),
                  textAlign: TextAlign.center,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
