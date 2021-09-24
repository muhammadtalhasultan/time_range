import 'package:flutter/material.dart';

abstract class ParamFactory {
  // Strings
  static const String time = '10:50';
  static const String firstTimeString = '10:10';
  static const String secondTimeString = '10:30';
  static const String toTitle = 'TO';
  static const String fromTitle = 'FROM';

  // int
  static const int timeStep = 10;
  static const int timeBlock = 20;

  // TimeOfDay
  static const TimeOfDay firstTime = TimeOfDay(hour: 10, minute: 10);
  static const TimeOfDay secondTime = TimeOfDay(hour: 10, minute: 40);

  // Colors
  static const Color blue = Colors.blue;
  static const Color purple = Colors.purple;

  // TextStyle
  static const TextStyle activeTextStyle = TextStyle(
    color: blue,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle textStyle = TextStyle(
    color: purple,
  );

  static bool isContainerWithColor(Widget widget, Color color) {
    if (widget is! Container || widget.decoration == null) {
      return false;
    }

    return (widget.decoration as BoxDecoration).color == color;
  }
}
