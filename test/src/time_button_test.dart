import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_range/src/time_button.dart';
import '../helpers/pump_app.dart';
import '../utils/param_factory.dart';

void main() {
  group(
    'TimeButton',
    () {
      group(
        'Render',
        () {
          testWidgets('text with time value', (WidgetTester tester) async {
            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                onSelect: (time) {},
              ),
            );

            final text = find.text(ParamFactory.time);
            expect(text, findsOneWidget);
          });
        },
      );
      group('Style', () {
        testWidgets(
          'change background color if button is tapped',
          (WidgetTester tester) async {
            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                onSelect: (time) {},
                activeBackgroundColor: ParamFactory.blue,
                backgroundColor: ParamFactory.purple,
              ),
            );

            final timeButton = find.byType(TimeButton);

            final unselectedWidgetBackgroundColor = (tester
                    .widget<Container>(find.byType(Container))
                    .decoration as BoxDecoration)
                .color;

            expect(
              unselectedWidgetBackgroundColor,
              ParamFactory.purple,
            );

            await tester.tap(timeButton);
            await tester.pump();

            final selectedWidgetBackgroundColor = (tester
                    .widget<Container>(find.byType(Container))
                    .decoration as BoxDecoration)
                .color;

            expect(
              selectedWidgetBackgroundColor,
              ParamFactory.blue,
            );
          },
        );
        testWidgets(
          'change text style if button is tapped',
          (WidgetTester tester) async {
            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                onSelect: (time) {},
                textStyle: ParamFactory.textStyle,
                activeTextStyle: ParamFactory.activeTextStyle,
              ),
            );

            final timeButton = find.byType(TimeButton);

            final unselectedWidgetTextStyle =
                (tester.widget<Text>(find.byType(Text)).style);

            expect(
              unselectedWidgetTextStyle,
              ParamFactory.textStyle,
            );

            await tester.tap(timeButton);
            await tester.pump();

            final selectedWidgetTextStyle =
                (tester.widget<Text>(find.byType(Text)).style);

            expect(
              selectedWidgetTextStyle,
              ParamFactory.activeTextStyle,
            );
          },
        );
      });
    },
  );
}
