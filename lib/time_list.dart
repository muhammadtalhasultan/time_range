import 'package:flutter/material.dart';
import 'package:time_range/time_button.dart';
import 'time_of_day_extension.dart';

class TimeList extends StatefulWidget {

  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final TimeOfDay initialTime;
  final int timeStep;
  final double padding;
  final void Function(TimeOfDay hour) onHourSelected;
  final Color textColor;
  final Color backgroundColor;
  final Color activeTextColor;
  final Color activeBackgroundColor;

  TimeList({
    Key key,
    this.padding,
    @required this.timeStep,
    @required this.firstTime,
    @required this.lastTime,
    @required this.onHourSelected,
    this.initialTime,
    this.textColor,
    this.backgroundColor,
    this.activeTextColor,
    this.activeBackgroundColor,
  }) : assert(firstTime != null && lastTime != null),
      assert(lastTime.after(firstTime), 'lastTime not can be before firstTime'),
      assert(onHourSelected != null),
      super(key: key);
  
  @override
  _TimeListState createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {

  final ScrollController _scrollController = ScrollController();
  final double itemExtent = 85;
  TimeOfDay _selectedHour;
  List<TimeOfDay> hours = [];

  @override
  void initState() {
    super.initState();
    _initialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateScroll(hours.indexOf(widget.initialTime));
    });
  }

  @override
  void didUpdateWidget(TimeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.firstTime != widget.firstTime || oldWidget.timeStep != widget.timeStep) {
      _initialData();
      _animateScroll(hours.indexOf(widget.initialTime));
    }
  }

  _initialData() {
    _selectedHour = widget.initialTime;
    _loadHours();
  }

  void _loadHours() {
    hours.clear();
    var hour = TimeOfDay(hour: widget.firstTime.hour, minute: widget.firstTime.minute);
    while(hour.before(widget.lastTime)) {
      hours.add(hour);
      hour = hour.add(minutes: widget.timeStep);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: widget.padding),
        itemCount: hours.length,
        itemExtent: itemExtent,
        itemBuilder: (BuildContext context, int index) {

          final hour = hours[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TimeButton(
              textColor: widget.textColor,
              backgroundColor: widget.backgroundColor,
              activeTextColor: widget.activeTextColor,
              activeBackgroundColor: widget.activeBackgroundColor,
              time: hour.hhmm(),
              value: _selectedHour == hour,
              onSelect: (_) => _selectHour(index, hour),
            ),
          );
        },
      ),
    );
  }

  void _selectHour(int index, TimeOfDay hour) {
    _selectedHour = hour;
    _animateScroll(index);
    widget.onHourSelected(hour);
    setState(() {});
  }

  void _animateScroll(int index) {
    double offset = index < 0 ? 0 : index * itemExtent;
    if (offset > _scrollController.position.maxScrollExtent) {
      offset = _scrollController.position.maxScrollExtent;
    }
    _scrollController.animateTo(offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn);
  }

}
