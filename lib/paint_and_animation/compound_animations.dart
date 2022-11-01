import 'package:flutter/material.dart';

class FadePosition {
  final double opacity;
  final Offset offset;

  const FadePosition(this.opacity, this.offset);

  FadePosition operator *(double multiplier) =>
      FadePosition(opacity * multiplier, offset * multiplier);

  FadePosition operator +(FadePosition other) =>
      FadePosition(opacity + other.opacity, offset + other.offset);

  FadePosition operator -(FadePosition other) =>
      FadePosition(opacity - other.opacity, offset - other.offset);
}

class SlideAndFadeTransition extends AnimatedWidget {
  final Animatable fade;
  final Widget child;
  const SlideAndFadeTransition({
    Key? key,
    required Animation<double> progress,
    required this.fade,
    required this.child,
  }) : super(key: key, listenable: progress);

  Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final currentValue = fade.evaluate(_animation);
    // final detailsCurrentValue = detailsTween.evaluate(_animation);
    return Transform.translate(
      offset: currentValue.offset,
      child: Opacity(
        opacity: currentValue.opacity,
        child: child,
      ),
    );
  }
}

class FadePositionScale {
  final FadePosition fadePosition;
  final double scale;

  const FadePositionScale(this.fadePosition, this.scale);

  FadePositionScale operator *(double multiplier) =>
      FadePositionScale(fadePosition * multiplier, scale * multiplier);

  FadePositionScale operator +(FadePositionScale other) =>
      FadePositionScale(fadePosition + other.fadePosition, scale + other.scale);

  FadePositionScale operator -(FadePositionScale other) =>
      FadePositionScale(fadePosition - other.fadePosition, scale - other.scale);
}

class FadePositionScaleTransition extends AnimatedWidget {
  final Animatable fade;
  final Widget child;
  const FadePositionScaleTransition({
    Key? key,
    required Animation<double> progress,
    required this.fade,
    required this.child,
  }) : super(key: key, listenable: progress);

  Animation<double> get _animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final currentValue = fade.evaluate(_animation);
    return Opacity(
      opacity: currentValue.fadePosition.opacity,
      child: Transform.translate(
        offset: currentValue.fadePosition.offset,
        child: Transform.scale(
          scale: currentValue.scale,
          child: child,
        ),
      ),
    );
  }
}
