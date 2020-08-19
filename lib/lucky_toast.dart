import 'package:flutter/material.dart';
import 'package:lucky_toast/toast/toast_animate.dart';
import 'package:lucky_toast/toast/toast_controller.dart';
import 'package:lucky_toast/toast/toast_widget.dart';

export 'package:lucky_toast/toast/toast_animate.dart';

class LuckyToast {
  static LuckyToast _instance = LuckyToast();

  static void simpleShow(String msg, {Duration duration}) {
    _instance._showToast(msg, duration: duration);
  }

  static setToastAnimated(ToastAnimatedBase toastAnimated) {
    _instance.toastAnimated = toastAnimated;
  }

  static void get dismiss {
    ToastViewController.preToast?.dismiss();
  }

  BuildContext _context;
  ToastAnimatedBase _toastAnimated;

  set toastAnimated(ToastAnimatedBase toastAnimated) {
    _toastAnimated = toastAnimated;
  }

  set context(BuildContext context) {
    _context = context;
  }

  void _showToast(String msg, {Duration duration}) {
    ToastViewController.preToast?.dismiss();
    var overlayState = Overlay.of(_context);
    AnimationController animationController =
        _toastAnimated.createAnimatedController(overlayState);
    _toastAnimated.child = ToastWidget(msg: msg);
    OverlayEntry overlayEntry =
        OverlayEntry(builder: (context) => _toastAnimated.builder(context));
    ToastViewController.preToast = ToastViewController(
        overlayState: overlayState,
        overlayEntry: overlayEntry,
        animationController: animationController,
        duration: duration)
      ..show();
  }
}

class LuckyToastCtxGet extends StatelessWidget {
  final Widget child;

  final TextDirection textDirection;

  LuckyToastCtxGet({
    Key key,
    @required this.child,
    this.textDirection = TextDirection.ltr,
    ToastAnimatedBase toastAnimated,
  }) : super(key: key) {
    LuckyToast._instance.toastAnimated =
        toastAnimated ?? DefaultToastAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext _context) {
              LuckyToast._instance.context = _context;
              return child;
            },
          ),
        ],
      ),
      textDirection: textDirection,
    );
  }
}
