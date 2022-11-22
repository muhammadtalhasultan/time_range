import 'package:flutter/material.dart';

import 'time_list.dart';
import 'util/exclude_time_model.dart';
import 'util/time_of_day_extension.dart';

export 'package:time_range/src/util/exclude_time_model.dart';
export 'package:time_range/src/util/time_of_day_extension.dart';

typedef TimeRangeSelectedCallback = void Function(TimeRangeResult? range);

class TimeRange extends StatefulWidget {
  final int timeStep;
  final int timeBlock;
  final int? minimalTimeRange;
  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final Widget? fromTitle;
  final Widget? toTitle;
  final double titlePadding;
  final TimeRangeSelectedCallback onRangeCompleted;
  final TimeRangeResult? initialRange;
  final Color? borderColor;
  final Color? activeBorderColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;
  final bool alwaysUse24HourFormat;
  final List<ExcludedTime>? excludedTime;
  final bool? resetTime;

  TimeRange({
    Key? key,
    required this.timeBlock,
    required this.onRangeCompleted,
    required this.firstTime,
    required this.lastTime,
    this.minimalTimeRange,
    this.timeStep = 60,
    this.fromTitle,
    this.toTitle,
    this.titlePadding = 0,
    this.initialRange,
    this.borderColor,
    this.activeBorderColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.textStyle,
    this.activeTextStyle,
    this.alwaysUse24HourFormat = false,
    this.excludedTime,
    this.resetTime,
  })  : assert(
            lastTime.after(firstTime), 'lastTime can not be before firstTime'),
        super(key: key);

  @override
  State<TimeRange> createState() => _TimeRangeState();
}

class _TimeRangeState extends State<TimeRange> {
  TimeOfDay? _startHour, _endHour, lastEnabledHour;

  @override
  void initState() {
    super.initState();
    setRange();
  }

  @override
  void didUpdateWidget(TimeRange oldWidget) {
    super.didUpdateWidget(oldWidget);
    setRange();
  }

  void setRange() {
    if (widget.initialRange != null) {
      _startHour = widget.initialRange!.start;
      _endHour = widget.initialRange!.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.resetTime == true) {
      setState(() => _startHour = _endHour = lastEnabledHour = null);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.fromTitle != null)
          Padding(
            padding: EdgeInsets.only(left: widget.titlePadding, bottom: 8),
            child: widget.fromTitle,
          ),
        TimeList(
          position: Position.start,
          excludedTime: widget.excludedTime,
          firstTime: widget.firstTime,
          lastTime: widget.lastTime
              .subtract(minutes: widget.minimalTimeRange ?? widget.timeBlock),
          initialTime: _startHour,
          timeStep: widget.timeStep,
          padding: widget.titlePadding,
          onHourSelected: _startHourChanged,
          borderColor: widget.borderColor,
          activeBorderColor: widget.activeBorderColor,
          backgroundColor: widget.backgroundColor,
          activeBackgroundColor: widget.activeBackgroundColor,
          textStyle: widget.textStyle,
          activeTextStyle: widget.activeTextStyle,
          alwaysUse24HourFormat: widget.alwaysUse24HourFormat,
        ),
        if (widget.toTitle != null)
          Padding(
            padding: EdgeInsets.only(left: widget.titlePadding, top: 8),
            child: widget.toTitle,
          ),
        const SizedBox(height: 8),
        TimeList(
          lastEnabledHour: lastEnabledHour,
          position: Position.end,
          excludedTime: widget.excludedTime,
          firstTime: _getFirstTimeEndHour(),
          lastTime: widget.lastTime,
          initialTime: _endHour,
          timeStep: widget.timeBlock,
          padding: widget.titlePadding,
          onHourSelected: _endHourChanged,
          borderColor: widget.borderColor,
          activeBorderColor: widget.activeBorderColor,
          backgroundColor: widget.backgroundColor,
          activeBackgroundColor: widget.activeBackgroundColor,
          textStyle: widget.textStyle,
          activeTextStyle: widget.activeTextStyle,
          alwaysUse24HourFormat: widget.alwaysUse24HourFormat,
        ),
      ],
    );
  }

  TimeOfDay _getFirstTimeEndHour() {
    int timeMinutes = widget.minimalTimeRange ?? widget.timeBlock;

    return _startHour == null
        ? widget.firstTime.add(minutes: timeMinutes)
        : _startHour!.add(minutes: timeMinutes);
  }

  double toDouble(TimeOfDay? myTime) =>
      (myTime?.hour ?? 0) + (myTime?.minute ?? 0) / 60.0;

  void _startHourChanged(TimeOfDay hour) {
    setState(() {
      _endHour = lastEnabledHour = null;
      _startHour = hour;
    });

    Iterable<ExcludedTime>? exceed =
        widget.excludedTime?.where((e) => hour.beforeOrEqual(e.start));
    if (exceed?.isNotEmpty == true) {
      lastEnabledHour = exceed?.first.start;
    }

    if (_endHour != null) {
      if (_endHour!.inMinutes() <= _startHour!.inMinutes() ||
          (_endHour!.inMinutes() - _startHour!.inMinutes())
                  .remainder(widget.timeBlock) !=
              0) {
        _endHour = null;
        widget.onRangeCompleted(null);
      } else {
        widget.onRangeCompleted(TimeRangeResult(_startHour!, _endHour!));
      }
    }
  }

  void _endHourChanged(TimeOfDay hour) {
    setState(() => _endHour = hour);
    // Check if the [starthour] is not null since it's possible that
    // the user first select the [endhour] and then the [starthour].
    if (_startHour != null) {
      widget.onRangeCompleted(TimeRangeResult(_startHour!, _endHour!));
    }
  }
}

class TimeRangeResult {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRangeResult(this.start, this.end);
}
