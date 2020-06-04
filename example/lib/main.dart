import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;

  final _defaultTimeRange = TimeRangeResult(
    TimeOfDay(hour: 14, minute: 50),
    TimeOfDay(hour: 15, minute: 20),
  );
  TimeRangeResult _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: leftPadding),
                child: Text(
                  'Opening Times',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold, color: dark),
                ),
              ),

              SizedBox(height: 20),

              TimeRange(
                fromTitle: Text(
                  'From',
                  style: TextStyle(fontSize: 18, color: dark),
                ),
                toTitle: Text(
                  'To',
                  style: TextStyle(fontSize: 18, color: dark),
                ),
                titlePadding: leftPadding,
                textColor: dark,
                activeTextColor: orange,
                backgroundColor: Colors.transparent,
                activeBackgroundColor: dark,
                firstTime: TimeOfDay(hour: 8, minute: 00),
                lastTime: TimeOfDay(hour: 20, minute: 00),
                initialRange: _timeRange,
                timeStep: 10,
                timeBlock: 30,
                onRangeCompleted: (range) => setState(() => _timeRange = range),
              ),
              SizedBox(height: 30),
              if (_timeRange != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selected Range: ${_timeRange.start.hhmm()} - ${_timeRange.end.hhmm()}',
                        style: TextStyle(fontSize: 20, color: dark),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        child: Text('Default'),
                        onPressed: () => setState(() => _timeRange = _defaultTimeRange),
                        color: orange,
                      )
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
