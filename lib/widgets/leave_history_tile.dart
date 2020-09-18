import 'package:flutter/material.dart';

class LeaveHistoryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
          leading: Icon(
            Icons.check_circle_outline,
            size: 45,
            color: Colors.teal,
          ),
          title: Text('Type of leave'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.calendar_today, size: 12),
                  SizedBox(width: 5),
                  Text('From'),
                  Text(' - '),
                  Text('To'),
                  Text(' '),
                  Text('Approved / Rejected'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Applied on'),
                  Text(' '),
                  Text('__/__/____'),
                ],
              ),
            ],
          ),
          onTap: () {},
    );
  }
}
