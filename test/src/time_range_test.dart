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
    },
  );
}
