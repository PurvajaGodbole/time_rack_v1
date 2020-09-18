import 'package:flutter/material.dart';

import '../widgets/leave_history_tile.dart';
import '../forms/leave_application_form.dart';
import '../widgets/app_drawer.dart';

class LeaveStatusScreen extends StatefulWidget {
  static const routeName = '/leave-status';

  @override
  _LeaveStatusScreenState createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Leave Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Form(
            child: Card(
              child: LeaveApplicationForm(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (ctx, index) => Card(
                child: LeaveHistoryTile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
