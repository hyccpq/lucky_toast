import 'package:flutter/material.dart';

import 'package:lucky_toast/lucky_toast.dart';
import 'package:lucky_toast_example/toast_animate.dart';

void main() {
  runApp(LuckyToastCtxGet(child: MyApp(), showDuration: Duration(seconds: 1)));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ToastAnimatedBase toastAnimated;

  void showToast() {
    LuckyToast.simpleShow('Hey guys, Good luck!!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: showToast, child: Text('show toast!!')),
              UseCustom()
            ]),
      ),
    );
  }
}

class UseCustom extends StatefulWidget {
  @override
  _UseCustomState createState() => _UseCustomState();
}

class _UseCustomState extends State<UseCustom> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Using custom animations:'),
        Switch(value: _isOpen, onChanged: useCustomSetting),
      ],
    );
  }
}

extension on _UseCustomState {
  void useCustomSetting(bool isOpen) {
    if (isOpen) {
      LuckyToast.setToastAnimated(CustomToastAnimation());
    } else {
      LuckyToast.setToastAnimated(DefaultToastAnimation());
    }
    setState(() {
      _isOpen = isOpen;
    });
  }
}
