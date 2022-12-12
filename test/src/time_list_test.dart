import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_range/src/util/time_of_day_extension.dart';
import 'package:time_range/time_range.dart';

import '../helpers/pump_app.dart';
import '../utils/param_factory.dart';

void main() {
  group(
    'TimeList',
    () {
      group(
        'Render',
        () {
          testWidgets('a list of hours', (WidgetTester tester) async {
            await tester.pumpApp(
              TimeList(
                timeStep: ParamFactory.timeStep,
                firstTime: ParamFactory.firstTime,
                lastTime: ParamFactory.secondTime,
                onHourSelected: (hour) {},
              ),
            );

            final widgetList = find.byType(TimeButton);
            final numberOfWidget = ParamFactory.firstTime
                        .subtract(minutes: ParamFactory.secondTime.inMinutes())
                        .inMinutes() /
                    ParamFactory.timeStep +
                1;

            expect(
              widgetList.evaluate().length,
              numberOfWidget,
            );
          });
          testWidgets(
              'zero active child widget if we '
              'do not passed [initialTime]', (WidgetTester tester) async {
            await tester.pumpApp(
              TimeList(
                timeStep: ParamFactory.timeStep,
                firstTime: ParamFactory.firstTime,
                lastTime: ParamFactory.secondTime,
                activeBackgroundColor: ParamFactory.blue,
                backgroundColor: ParamFactory.purple,
                onHourSelected: (hour) {},
              ),
            );

            final activeChild = find.byWidgetPredicate((widget) {
              if (widget is! Container || widget.decoration == null) {
                return false;
              }

              return (widget.decoration! as BoxDecoration).color ==
                  ParamFactory.blue;
            });

            expect(activeChild, findsNothing);
          });
          testWidgets(
            'Only one active child widget if we '
            'passed [initialTime]',
            (WidgetTester tester) async {
              await tester.pumpApp(
                TimeList(
                  timeStep: ParamFactory.timeStep,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  activeBackgroundColor: ParamFactory.blue,
                  backgroundColor: ParamFactory.purple,
                  initialTime: ParamFactory.firstTime,
                  onHourSelected: (hour) {},
                ),
              );

              final activeChild = find.byWidgetPredicate((widget) {
                if (widget is! Container || widget.decoration == null) {
                  return false;
                }

                return (widget.decoration! as BoxDecoration).color ==
                    ParamFactory.blue;
              });

              expect(activeChild, findsOneWidget);
            },
          );
        },
      );
      group(
        'change',
        () {
          testWidgets(
            'active child when an unselected child is tapped',
            (WidgetTester tester) async {
              await tester.pumpApp(
                TimeList(
                  timeStep: ParamFactory.timeStep,
                  firstTime: ParamFactory.firstTime,
                  lastTime: ParamFactory.secondTime,
                  activeBackgroundColor: ParamFactory.blue,
                  backgroundColor: ParamFactory.purple,
                  onHourSelected: (hour) {},
                ),
              );

              final inactiveChild = find.byWidgetPredicate((widget) {
                if (widget is! Container || widget.decoration == null) {
                  return false;
                }

                return (widget.decoration! as BoxDecoration).color ==
                    ParamFactory.blue;
              });

              expect(inactiveChild, findsNothing);

              final unSelectedChild = find.byType(TimeButton).first;
              await tester.tap(unSelectedChild);
              await tester.pumpAndSettle();

              final activeChild = find.byWidgetPredicate(
                (widget) => ParamFactory.isContainerWithColor(
                  widget,
                  ParamFactory.blue,
                ),
              );

              expect(activeChild, findsOneWidget);
            },
          );
        },
      );
    },
  );
}
