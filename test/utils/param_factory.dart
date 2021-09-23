import 'package:flutter/material.dart';

abstract class ParamFactory {
  // Strings
  static const String time = '10:50';

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
}
