import 'package:flutter/material.dart';

class TimeButton extends StatefulWidget {

  final String time;
  final Function onSelect;
  final bool value;
  final Color textColor;
  final Color backgroundColor;
  final Color activeTextColor;
  final Color activeBackgroundColor;

  const TimeButton({
    Key key, 
    this.time, 
    this.onSelect, 
    this.value = false, 
    this.textColor, 
    this.backgroundColor, 
    this.activeTextColor, 
    this.activeBackgroundColor
  }) : super(key: key);

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
      elevation: 0,
      color: isSelected
        ? widget.activeBackgroundColor ?? Theme.of(context).primaryColor
        : widget.backgroundColor ?? Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide( color: isSelected
            ? widget.activeTextColor ?? Colors.white
            : widget.textColor ?? Theme.of(context).primaryColor),
      ),
      child: Text(
        widget.time,
        style: TextStyle(
          fontSize: 16,
          color: isSelected
            ? widget.activeTextColor ?? Colors.white
            : widget.textColor ?? Colors.white,
        ),
      ),
      onPressed: () {
        if (!isSelected) {
          isSelected = true;
          widget.onSelect(widget.time);
        }
        setState(() {});
      },
    );
  }
}
