
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
  static const white = Color(0xFFF2F2F2);
  static const gray = Color(0xFF90A8C6);

  TimeRangeResult _timeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Column(
        children: <Widget>[

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Flutter Time Range Example',
                style: Theme.of(context).textTheme.title
                  .copyWith(fontWeight: FontWeight.bold, color: orange),
              ),
            ),
          ),

          TimeRange(
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
            onRangeCompleted: (range) => setState(() => _timeRange = range),
          ),

          SizedBox(height: 30),

          if (_timeRange != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Selected Range: ${_timeRange.start.hhmm()} - ${_timeRange.end.hhmm()}',
                style: TextStyle(fontSize: 20, color: gray),
              ),
            )
        ],
      )
    );
  }
}
