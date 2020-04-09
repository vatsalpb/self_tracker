import 'package:flutter/material.dart';
import 'package:selftracker/src/TimerSettingScreen.dart';
import 'package:selftracker/src/TimerScreen.dart';

void main() {
  //runApp(App());
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => TimerScreen(),
      '/second': (context) => TimerSettingScreen(),
    },
  ));
}
