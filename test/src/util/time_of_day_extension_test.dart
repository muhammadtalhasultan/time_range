import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_range/src/util/time_of_day_extension.dart';

void main() {
  final smallTime = TimeOfDay(hour: 10, minute: 20);
  final bigTime = TimeOfDay(hour: 40, minute: 40);
  final cloneBigTime = TimeOfDay(hour: 40, minute: 40);

  group(
    'TimeOfDayExtension',
    () {
      group(
        'Method',
        () {
          group(
            'compare',
            () {
              test(
                'Return a positive number if first time is bigger than '
                'second time',
                () {
                  final result = bigTime.compare(smallTime);
                  expect(result, isPositive);
                },
              );
              test(
                'Return a negative number if first time is smaller than '
                'second time',
                () {
                  final result = smallTime.compare(bigTime);
                  expect(result, isNegative);
                },
              );
              test(
                'Return 0 if both date are equals',
                () {
                  final result = bigTime.compare(cloneBigTime);
                  expect(result, isZero);
                },
              );
            },
          );
          group(
            'inMinutes',
            () {
              test(
                'return a int with the time in minutes',
                () {
                  final result = smallTime.inMinutes();
                  final minutes = smallTime.hour * 60 + smallTime.minute;
                  expect(result, equals(minutes));
                },
              );
            },
          );
          group(
            'before',
            () {
              test(
                'return false if first time is bigger or equal than '
                'second time',
                () {
                  final result = bigTime.before(smallTime);
                  expect(result, isFalse);
                },
              );
              test(
                'return true if first time is smaller than second time',
                () {
                  final result = smallTime.before(bigTime);
                  expect(result, isTrue);
                },
              );
            },
          );
          group(
            'after',
            () {
              test(
                'return true if first time if bigger than second time',
                () {
                  final result = bigTime.after(smallTime);
                  expect(result, isTrue);
                },
              );
              test(
                'return false if first time if smaller or equal '
                'than second time',
                () {
                  final result = smallTime.after(bigTime);
                  expect(result, isFalse);
                },
              );
            },
          );
          group(
            'add',
            () {
              test(
                'return a [TimeOfDay] instance with the sum of previous time plus '
                'minutes that we have passed to method',
                () {
                  final summedInstance = smallTime.add(minutes: 20);
                  final expectedValue = TimeOfDay(
                    hour: smallTime.hour,
                    minute: smallTime.minute + 20,
                  );
                  expect(summedInstance, equals(expectedValue));
                },
              );
            },
          );
          group(
            'subtract',
            () {
              test(
                'return a [TimeOfDay] instance with the subtract of previous time minus '
                'minutes that we have passed to method',
                () {
                  final subtractedInstance = smallTime.subtract(minutes: 10);
                  final expectedValue = TimeOfDay(
                    hour: smallTime.hour,
                    minute: smallTime.minute - 10,
                  );
                  expect(subtractedInstance, equals(expectedValue));
                  //expect(result, result);
                },
              );
            },
          );
          group(
            'beforeOrEqual',
            () {
              test(
                'return false if first time is bigger than second time',
                () {
                  final result = bigTime.beforeOrEqual(smallTime);
                  expect(result, isFalse);
                },
              );
              test(
                'return true if first time is smaller than second time',
                () {
                  final result = smallTime.beforeOrEqual(bigTime);
                  expect(result, isTrue);
                },
              );
              test(
                'return true if first time is equal than second time',
                () {
                  final result = bigTime.beforeOrEqual(cloneBigTime);
                  expect(result, isTrue);
                },
              );
            },
          );
          group(
            'afterOrEqual',
            () {
              test(
                'return true if first time if bigger than second time',
                () {
                  final result = bigTime.afterOrEqual(smallTime);
                  expect(result, isTrue);
                },
              );
              test(
                'return true if first time if equal than second time',
                    () {
                  final result = bigTime.afterOrEqual(cloneBigTime);
                  expect(result, isTrue);
                },
              );
              test(
                'return false if first time if smaller or equal '
                'than second time',
                () {
                  final result = smallTime.afterOrEqual(bigTime);
                  expect(result, isFalse);
                },
              );
            },
          );
        },
      );
    },
  );
}
