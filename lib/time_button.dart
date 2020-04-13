import 'package:flutter/material.dart';

class TimeButton extends StatefulWidget {

  final String hour;
  final Function onSelect;
  final bool value;

  const TimeButton({Key key, this.hour, this.onSelect, this.value = false}) : super(key: key);

  @override
  _TimeButtonState createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {

  bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value;
  }

  @override
  void didUpdateWidget(TimeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSelected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        widget.hour,
        style: TextStyle(
            color: isSelected
                ? Theme.of(context).accentColor
                : Colors.white),
      ),
      color: isSelected
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.white)),
      onPressed: () {
        if (!isSelected) {
          isSelected = true;
          widget.onSelect(widget.hour);
        }
        setState(() {});
      },
    );
  }
}
