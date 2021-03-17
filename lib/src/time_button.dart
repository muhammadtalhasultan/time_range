import 'package:flutter/material.dart';

class TimeButton extends StatefulWidget {
  final String? time;
  final Function? onSelect;
  final bool value;
  final Color? borderColor;
  final Color? activeBorderColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;

  const TimeButton(
      {Key? key,
      this.time,
      this.onSelect,
      this.value = false,
      this.borderColor,
      this.activeBorderColor,
      this.backgroundColor,
      this.activeBackgroundColor,
      this.textStyle,
      this.activeTextStyle})
      : super(key: key);

  @override
  _TimeButtonState createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  late bool isSelected;

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
          widget.onSelect!(widget.time);
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
                  ? widget.activeBorderColor ?? Theme.of(context).primaryColor
                  : widget.borderColor ?? Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.time!,
                style: isSelected ? widget.activeTextStyle : widget.textStyle),
          ),
        ),
      ),
    );
  }
}
