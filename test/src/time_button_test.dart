import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_range/time_range.dart';

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
          'change background color according tu value of [value]',
          (WidgetTester tester) async {
            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                activeBackgroundColor: ParamFactory.blue,
                backgroundColor: ParamFactory.purple,
                onSelect: (time) {},
              ),
            );

            final unselectedWidgetBackgroundColor = (tester
                    .widget<Container>(find.byType(Container))
                    .decoration! as BoxDecoration)
                .color;

            expect(
              unselectedWidgetBackgroundColor,
              ParamFactory.purple,
            );

            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                value: ParamFactory.isSelected,
                activeBackgroundColor: ParamFactory.blue,
                backgroundColor: ParamFactory.purple,
                onSelect: (time) {},
              ),
            );

            final selectedWidgetBackgroundColor = (tester
                    .widget<Container>(find.byType(Container))
                    .decoration! as BoxDecoration)
                .color;

            expect(
              selectedWidgetBackgroundColor,
              ParamFactory.blue,
            );
          },
        );
        testWidgets(
          'change text style according to value of [value]',
          (WidgetTester tester) async {
            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                textStyle: ParamFactory.textStyle,
                activeTextStyle: ParamFactory.activeTextStyle,
                onSelect: (time) {},
              ),
            );

            final unselectedWidgetTextStyle =
                tester.widget<Text>(find.byType(Text)).style;

            expect(
              unselectedWidgetTextStyle,
              ParamFactory.textStyle,
            );

            await tester.pumpApp(
              TimeButton(
                time: ParamFactory.time,
                value: ParamFactory.isSelected,
                textStyle: ParamFactory.textStyle,
                activeTextStyle: ParamFactory.activeTextStyle,
                onSelect: (time) {},
              ),
            );

            final selectedWidgetTextStyle =
                tester.widget<Text>(find.byType(Text)).style;

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
