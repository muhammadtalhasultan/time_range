import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Little extension to ease pump of a widget
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    return pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );
  }
}
