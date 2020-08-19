import 'package:flutter/material.dart';
import 'package:lucky_toast/lucky_toast.dart';

class CustomToastAnimation extends ToastAnimatedBase {
  CustomToastAnimation({Duration duration}) : super(duration: duration);

  @override
  Widget builder(BuildContext context) => AnimatedBuilder(
        animation: animation,
        child: super.builder(context),
        builder: (context, child) {
          return Opacity(
            opacity: animation.value,
            child: Transform.scale(
              scale: Tween<double>(begin: 1.5, end: 1.0)
                  .transform(animation.value),
              child: child,
            ),
          );
        },
      );
}
