import 'package:flutter/material.dart';

abstract class ToastControllerBase {
  Future<void> show();

  Future<void> dismiss();
}

class ToastViewController implements ToastControllerBase {
  static ToastViewController preToast;

  final OverlayEntry overlayEntry;
  final OverlayState overlayState;
  final Duration duration; // 显示时长
  final AnimationController animationController;
  bool dismissed = false;

  ToastViewController(
      {this.animationController,
      @required this.overlayEntry,
      @required this.overlayState,
      Duration duration})
      : this.duration = duration ?? const Duration(milliseconds: 2000);

  @override
  show() async {
    overlayState.insert(overlayEntry);
    animationController?.forward();
    await Future.delayed(duration);
    this.dismiss();
  }

  @override
  dismiss() async {
    if (dismissed) {
      return;
    }
    this.dismissed = true;
    animationController?.reverse();
    await Future.delayed(animationController.duration);
    overlayEntry?.remove();
  }
}
