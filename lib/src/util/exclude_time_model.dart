import 'package:flutter/material.dart';

class ExcludedTime {
  TimeOfDay start, end;
  ExcludedTime({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
