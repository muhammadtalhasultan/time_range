import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_range/src/time_list.dart';
import 'package:time_range/src/time_range.dart';

import '../helpers/pump_app.dart';
import '../utils/param_factory.dart';

void main() {
  group(
    'TimeRange',
    () {
      group(
        'Render',
        () {
          testWidgets('two list of time', (WidgetTester tester) async {
            await tester.pumpApp(
              TimeRange(
                timeBlock: ParamFactory.timeBlock,
                firstTime: ParamFactory.firstTime,
                lastTime: ParamFactory.secondTime,
                timeStep: ParamFactory.timeStep,
                onRangeCompleted: (range) {},
              ),
            );

            final timeList = find.byType(TimeList);

            expect(timeList, findsNWidgets(2));
          });
          testWidgets(
            'title for to and from widget if we pass those arguments',
            (WidgetTester tester) async {
              await tester.pumpApp(
                TimeRange(
                  timeBlock: ParamFactory.timeBlock,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  timeStep: ParamFactory.timeStep,
                  toTitle: Text(ParamFactory.toTitle),
                  fromTitle: Text(ParamFactory.fromTitle),
                  onRangeCompleted: (range) {},
                ),
              );

              final toTitleWidget = find.text(ParamFactory.toTitle);
              final fromTitleWidget = find.text(ParamFactory.fromTitle);

              expect(toTitleWidget, findsOneWidget);
              expect(fromTitleWidget, findsOneWidget);
            },
          );
        },
      );
      group(
        'Change',
        () {
          testWidgets(
            'selected [from] and [to] times if we tap a child of its '
            'respective list',
            (WidgetTester tester) async {
              await tester.pumpApp(
                TimeRange(
                  timeBlock: ParamFactory.timeBlock,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  timeStep: ParamFactory.timeStep,
                  toTitle: Text(ParamFactory.toTitle),
                  fromTitle: Text(ParamFactory.fromTitle),
                  activeBackgroundColor: ParamFactory.blue,
                  onRangeCompleted: (range) {},
                ),
              );

              var activeTimes = find.byWidgetPredicate(
                (widget) => ParamFactory.isContainerWithColor(
                  widget,
                  ParamFactory.blue,
                ),
              );
              expect(activeTimes, findsNothing);

              final fromTime = find.textContaining(RegExp('10:10'));
              expect(fromTime, findsOneWidget);

              await tester.tap(fromTime);
              await tester.pumpAndSettle();

              activeTimes = find.byWidgetPredicate(
                (widget) => ParamFactory.isContainerWithColor(
                  widget,
                  ParamFactory.blue,
                ),
              );
              expect(activeTimes, findsOneWidget);

              final toTime = find.textContaining(RegExp('10:30'));
              expect(toTime, findsOneWidget);

              await tester.tap(toTime);
              await tester.pumpAndSettle();

              activeTimes = find.byWidgetPredicate(
                (widget) => ParamFactory.isContainerWithColor(
                  widget,
                  ParamFactory.blue,
                ),
              );
              expect(activeTimes, findsNWidgets(2));
            },
          );
        },
      );
      group(
        'Function',
        () {
          testWidgets(
            'callback function is called when press a button',
            (WidgetTester tester) async {
              var callbackCalls = false;
              final onPressed =
                  (TimeRangeResult? result) => callbackCalls = true;

              await tester.pumpApp(
                TimeRange(
                  timeBlock: ParamFactory.timeBlock,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  timeStep: ParamFactory.timeStep,
                  toTitle: Text(ParamFactory.toTitle),
                  fromTitle: Text(ParamFactory.fromTitle),
                  activeBackgroundColor: ParamFactory.blue,
                  onRangeCompleted: (result) => onPressed(result),
                ),
              );

              final fromTime = find.textContaining(RegExp('10:10'));
              await tester.tap(fromTime);
              await tester.pumpAndSettle();

              final toTime = find.textContaining(RegExp('10:30'));
              await tester.tap(toTime);
              await tester.pumpAndSettle();

              expect(callbackCalls, isTrue);
            },
          );
        },
      );

      group(
        'Format',
        () {
          testWidgets(
            'format for time shown in time button is 24 hour format if we pass [alwaysUse24HourFormat] as true and 12 hr format if we pass false',
            (WidgetTester tester) async {
              final twelvehrFormat =
                  RegExp(r'^(1[0-2]|0?[1-9]):[0-5][0-9] (AM|PM)$');
              final twentyFourhrFormat = RegExp('r^(([01]?[0-9]|2[0-3]):[0-5][0-9])');

              await tester.pumpApp(
                TimeRange(
                  timeBlock: ParamFactory.timeBlock,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  onRangeCompleted: (result) {},
                  alwaysUse24HourFormat: ParamFactory.alwaysUser24HourFormat,
                ),
              );

              final fromTime = find.textContaining(
                  ParamFactory.alwaysUser24HourFormat
                      ? twentyFourhrFormat
                      : twelvehrFormat);

              final toTime = find.textContaining(
                  ParamFactory.alwaysUser24HourFormat
                      ? twentyFourhrFormat
                      : twelvehrFormat);

              expect(fromTime, findsWidgets);
              expect(toTime, findsWidgets);
            },
          );
        },
      );
    },
  );
}
