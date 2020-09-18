import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

import '../cards/attendance_history_card.dart';
import '../cards/office_space_card.dart';
import '../cards/leaves_status_card.dart';
import '../cards/attendance_summary_card.dart';
import '../cards/user_detail_card.dart';
import '../widgets/app_drawer.dart';

class MyDashboardScreen extends StatefulWidget {
  static const routeName = '/my-dashboard';

  @override
  _MyDashboardScreenState createState() => _MyDashboardScreenState();
}

class _MyDashboardScreenState extends State<MyDashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            OfficeSpaceCard(),
            SizedBox(height: 10),
            UserDetailCard(),
            SizedBox(height: 10),
            LeavesStatusCard(),
            SizedBox(height: 10),
            AttendanceSummaryCard(),
            SizedBox(height: 10),
            AttendanceHistoryCard(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
