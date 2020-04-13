
import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TimeRangeResult _timeRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Time Range Example'),
      ),
      body: Column(
        children: <Widget>[

          SizedBox(height: 10),

          Text('Select Range', style: TextStyle(fontWeight: FontWeight.bold),),

          SizedBox(height: 10),

          TimeRange(
            fromTitle: Text('From'),
            toTitle: Text('To'),
            titlePadding: 20,
            textColor: Colors.white,
            activeTextColor: Colors.amber,
            backgroundColor: Colors.blueGrey[300],
            activeBackgroundColor: Colors.blueGrey,
            firstTime: TimeOfDay(hour: 14, minute: 30),
            lastTime: TimeOfDay(hour: 20, minute: 00),
            timeStep: 10,
            timeBlock: 30,
            onRangeCompleted: (range) => setState(() => _timeRange = range),
          ),

          SizedBox(height: 10),

          if (_timeRange != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Selected Range: ${_timeRange.start.hhmm()} - ${_timeRange.end.hhmm()}',
                style: TextStyle(fontSize: 20),
              ),
            )
        ],
      )
    );
  }
}
