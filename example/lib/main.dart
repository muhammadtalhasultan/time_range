import 'package:flutter/material.dart';
import 'package:time_range/time_range.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const orange = Color(0xFFFE9A75);
  static const dark = Color(0xFF333A47);
  static const double leftPadding = 50;

  final _defaultTimeRange = TimeRangeResult(
    const TimeOfDay(hour: 14, minute: 00),
    const TimeOfDay(hour: 15, minute: 00),
  );
  TimeRangeResult? _timeRange;

  @override
  void initState() {
    super.initState();
    _timeRange = _defaultTimeRange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.bold, color: dark),
              ),
            ),
            const SizedBox(height: 20),
            TimeRange(
              fromTitle: const Text(
                'FROM',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              toTitle: const Text(
                'TO',
                style: TextStyle(
                  fontSize: 14,
                  color: dark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              titlePadding: leftPadding,
              textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: dark,
              ),
              activeTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: orange,
              ),
              borderColor: dark,
              activeBorderColor: dark,
              backgroundColor: Colors.transparent,
              activeBackgroundColor: dark,
              firstTime: const TimeOfDay(hour: 8, minute: 00),
              lastTime: const TimeOfDay(hour: 20, minute: 00),
              initialRange: _timeRange,
              timeStep: 30,
              timeBlock: 30,
              onRangeCompleted: (range) => setState(() => _timeRange = range),
              onFirstTimeSelected: (startHour) {},
            ),
            const SizedBox(height: 30),
            if (_timeRange != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: leftPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Selected Range: ${_timeRange!.start.format(context)} - ${_timeRange!.end.format(context)}',
                      style: const TextStyle(fontSize: 20, color: dark),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () =>
                          setState(() => _timeRange = _defaultTimeRange),
                      color: orange,
                      child: const Text('Default'),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
