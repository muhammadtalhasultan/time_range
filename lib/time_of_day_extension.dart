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
}
