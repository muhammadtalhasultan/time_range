# time_range

Flutter package for selecting a time range.

## Getting Started

You can use this package when you need to add a time range selector to your application. You can indicate the size of the steps of the initial time and the blocks of time that the range must contain. You can also customize the component styles.

![time_range_example.gif](time_range_example.gif)

## Properties

| Property              | Type                           | Description                                                                                                                                                                             |
|:----------------------|:-------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| fromTitle             | Widget                         | Widget displayed as the start time selector title                                                                                                                                       |
| toTitle               | Widget                         | Widget displayed as the end time selector title                                                                                                                                         |
| titlePadding          | double                         | Left padding applied to fromTitle and toTitle                                                                                                                                           |
| textColor             | Color                          | Time selection button text color                                                                                                                                                        |
| activeTextColor       | Color                          | Time selection button selected text color                                                                                                                                               |
| backgroundColor       | Color                          | Time selection button background color                                                                                                                                                  |
| activeBackgroundColor | Color                          | Time selection button selected background color                                                                                                                                         |
| firstTime             | TimeOfDay                      | Picker start time                                                                                                                                                                       |
| lastTime              | TimeOfDay                      | Picker end time                                                                                                                                                                         |
| timeStep              | double                         | Minutes jumps between initial selector hours                                                                                                                                            |
| timeBlock             | double                         | Size in minutes of time blocks. The final selector will be recalculated depending on the selected start time for the user to select a range that contains a multiple of this time range |
| onRangeCompleted      | void Function(TimeRangeResult) | Callback that notifies a change in the selected range. If, with a selected range, an initial time is selected again, the callback will return null.                                     |

## Use example

You can review the example folder for a complete example of using the widget.

`TimeRange(
    fromTitle: Text('From', style: TextStyle(fontSize: 18, color: gray),),
    toTitle: Text('To', style: TextStyle(fontSize: 18, color: gray),),
    titlePadding: 20,
    textColor: white,
    activeTextColor: dark,
    backgroundColor: Colors.transparent,
    activeBackgroundColor: orange,
    firstTime: TimeOfDay(hour: 14, minute: 30),
    lastTime: TimeOfDay(hour: 20, minute: 00),
    timeStep: 10,
    timeBlock: 30,
    onRangeCompleted: (range) => setState(() => print(range)),
  ),`