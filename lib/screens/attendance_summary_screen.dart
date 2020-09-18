import 'package:flutter/material.dart';

import '../cards/attendance_history_card.dart';
import '../cards/calender_card.dart';
import '../widgets/app_drawer.dart';

class AttendanceSummaryScreen extends StatefulWidget {
  static const routeName = '/attendance-summary';

  @override
  _AttendanceSummaryScreenState createState() =>
      _AttendanceSummaryScreenState();
}

class _AttendanceSummaryScreenState extends State<AttendanceSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Attendance Summary',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CalenderCard(),
          AttendanceHistoryCard(),
        ],
      ),
    );
  }
}
