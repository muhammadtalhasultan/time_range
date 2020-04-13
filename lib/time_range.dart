library time_range;

import 'package:flutter/material.dart';
import 'package:time_range/time_list.dart';
import 'package:time_range/time_of_day_extension.dart';

class HourRange extends StatefulWidget {
  final int timeStep;
  final int timeBlock;
  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final Widget fromTitle;
  final Widget toTitle;
  final double labelPadding;
  final void Function(TimeRangeResult range) onRangeCompleted;
  final TimeRangeResult initialRange;

  HourRange({
    Key key,
    this.timeStep = 60,
    @required this.timeBlock,
    @required this.onRangeCompleted,
    @required this.firstTime,
    @required this.lastTime,
    this.fromTitle,
    this.toTitle,
    this.labelPadding = 0,
    this.initialRange,
  }) : assert(timeBlock != null),
      assert(firstTime != null && lastTime != null),
      assert(lastTime.after(firstTime), 'lastTime not can be before firstTime'),
      assert(onRangeCompleted != null),
      super(key: key);

  @override
  _HourRangeState createState() => _HourRangeState();
}

class _HourRangeState extends State<HourRange> {

  TimeOfDay _startHour;
  TimeOfDay _endHour;

  @override
  void initState() {
    super.initState();
    if (widget.initialRange != null) {
      _startHour = widget.initialRange.start;
      _endHour = widget.initialRange.end;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        if (widget.fromTitle != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: widget.labelPadding),
            child: widget.fromTitle,
          ),

        TimeList(
          firstTime: widget.firstTime,
          lastTime: widget.lastTime.subtract(minutes: widget.timeBlock),
          initialTime: _startHour,
          timeBlock: widget.timeStep,
          padding: widget.labelPadding,
          onHourSelected: _startHourChanged,
        ),

        if (widget.toTitle != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.0, left: widget.labelPadding),
            child: widget.toTitle,
          ),

        TimeList(
          firstTime: _startHour == null
            ? widget.firstTime.add(minutes: widget.timeBlock)
            : _startHour.add(minutes: widget.timeBlock),
          lastTime: widget.lastTime,
          initialTime: _endHour,
          timeBlock: widget.timeBlock,
          padding: widget.labelPadding,
          onHourSelected: _endHourChanged,
        ),
      ],
    );
  }

  void _startHourChanged(TimeOfDay hour) {
    _startHour = hour;
    _endHour = null;
    setState((){});
    widget.onRangeCompleted(null);
  }

  void _endHourChanged(TimeOfDay hour) {
    setState(() => _endHour = hour);
    widget.onRangeCompleted(TimeRangeResult(_startHour, _endHour));
  }
}

class TimeRangeResult {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRangeResult(this.start, this.end);
}
