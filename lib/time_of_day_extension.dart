import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  int compare(TimeOfDay other) {
    return this.inMinutes() - other.inMinutes();
  }

  int inMinutes() {
    return this.hour * 60 + this.minute;
  }

  bool before(TimeOfDay other) {
    return this.compare(other) < 0;
  }

  bool after(TimeOfDay other) {
    return this.compare(other) > 0;
  }

  TimeOfDay add({int minutes}) {
    final total = this.inMinutes() + minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  TimeOfDay subtract({int minutes}) {
    final total = this.inMinutes() - minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  static TimeOfDay fromString(String time) {
    return TimeOfDay(
        hour: int.parse(time.split(":")[0]),
        minute: int.parse(time.split(":")[1]));
  }

  String hhmm() {
    String _addLeadingZeroIfNeeded(int value) {
      if (value < 10) return '0$value';
      return value.toString();
    }

    final String hourLabel = _addLeadingZeroIfNeeded(hour);
    final String minuteLabel = _addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
}
