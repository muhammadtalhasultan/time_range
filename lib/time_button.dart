import 'package:flutter/material.dart';

class TimeButton extends StatefulWidget {
  final String time;
  final Function onSelect;
  final bool value;
  final Color textColor;
  final Color backgroundColor;
  final Color activeTextColor;
  final Color activeBackgroundColor;

  const TimeButton(
      {Key key,
      this.time,
      this.onSelect,
      this.value = false,
      this.textColor,
      this.backgroundColor,
      this.activeTextColor,
      this.activeBackgroundColor})
      : super(key: key);

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
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          isSelected = true;
          widget.onSelect(widget.time);
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
            ? widget.activeBackgroundColor ?? Theme.of(context).primaryColor
            : widget.backgroundColor ?? Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
              ? widget.activeBackgroundColor ?? Theme.of(context).primaryColor
              : widget.textColor ?? Theme.of(context).primaryColor
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.time,
              style: TextStyle(
                color: isSelected
                    ? widget.activeTextColor ?? Colors.white
                    : widget.textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
