import 'package:flutter/material.dart';

abstract class ToastAnimatedBase {
  final Duration duration;
  Widget _child;
  @protected
  AnimationController animationController;
  @protected
  Animation<double> animation;

  set child(Widget child) => _child = child;

  ToastAnimatedBase({Duration duration})
      : duration = duration ?? Duration(milliseconds: 250);

  AnimationController createAnimatedController(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    return animationController;
  }

  @mustCallSuper
  Widget builder(BuildContext context) => _child;
}

class DefaultToastAnimation extends ToastAnimatedBase {
  DefaultToastAnimation({Duration duration}) : super(duration: duration);

  @override
  Widget builder(BuildContext context) => AnimatedBuilder(
        animation: animation,
        child: super.builder(context),
        builder: (context, child) {
          return Opacity(
            opacity: animation.value,
            child: Transform.translate(
              offset: Tween<Offset>(begin: Offset(0.0, -50.0), end: Offset.zero)
                  .animate(CurvedAnimation(
                      parent: animation, curve: _BounceOutCurve._()))
                  .value,
              child: child,
            ),
          );
        },
      );
}

class _BounceOutCurve extends Curve {
  const _BounceOutCurve._();

  @override
  double transform(double t) {
    t -= 1.0;
    return t * t * ((2 + 1) * t + 2) + 1.0;
  }
}
