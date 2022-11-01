import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/global_constants.dart';
import 'painters.dart';

class NavButton extends StatefulWidget {
  final String? route;
  final Map<String, String>? params;
  final double fontSize;

  final Widget? child;
  final String? label;
  final EdgeInsets padding;

  final Color color;
  final Function()? onPressedVoid;
  final Function(BuildContext, String, Map<String, String>)? onPressed;

  const NavButton({
    super.key,
    this.child,
    this.label,
    this.route,
    this.params,
    this.fontSize = 80,
    this.color = SECONDARY_LIGHTER,
    this.onPressed,
    this.onPressedVoid,
    this.padding = const EdgeInsets.all(50),
  });

  @override
  NavButtonState createState() => NavButtonState();
}

class NavButtonState extends State<NavButton>
    with SingleTickerProviderStateMixin {
  bool hover = false;
  late AnimationController controller;
  late TextStyle style;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    style = kNavButtonTextStyle.copyWith(color: widget.color);
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
        onEnter: _enter,
        onExit: _exit,
        child: GestureDetector(
          onTap: () => _tap(context),
          child: Stack(
            children: [
              Positioned.fill(
                  child: RepaintBoundary(
                child: CustomPaint(
                    painter: AnimatedBorderPainter(controller,
                        label: widget.label, color: widget.color)),
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.child ??
                    Text(widget.label ?? 'no label or child found',
                        style: style.copyWith(fontSize: widget.fontSize)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _enter(PointerEnterEvent) => controller.forward();
  void _exit(PointerExitEvent) => controller.reverse();
  void _tap(BuildContext context) {
    if (widget.onPressed != null) {
      widget.onPressed!(context, widget.route!, widget.params ?? {});
    } else if (widget.onPressedVoid != null) {
      widget.onPressedVoid!();
    } else {
      context.goNamed(widget.route!, params: widget.params ?? {});
    }
  }
}
