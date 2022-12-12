import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  int compare(TimeOfDay other) {
    return inMinutes() - other.inMinutes();
  }

  int inMinutes() {
    return hour * 60 + minute;
  }

  bool before(TimeOfDay other) {
    return compare(other) < 0;
  }

  bool after(TimeOfDay other) {
    return compare(other) > 0;
  }

  TimeOfDay add({required int minutes}) {
    final total = inMinutes() + minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  TimeOfDay subtract({required int minutes}) {
    final total = inMinutes() - minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  bool beforeOrEqual(TimeOfDay other) {
    return compare(other) <= 0;
  }

  bool afterOrEqual(TimeOfDay other) {
    return compare(other) >= 0;
  }
}
