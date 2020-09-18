import 'package:flutter/material.dart';

class AttendanceHistoryTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Column(
          children: <Widget>[
            Text("Check In"),
            Text("Time"),
            Text("__:__ AM"),
          ],
        ),
        title: Row(
          children: <Widget>[
            Icon(Icons.calendar_today, size: 12),
            SizedBox(width: 5),
            Text('__/__/____, ______day'),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Total hours'),
                Text(' - '),
                Text('__Hr'),
                Text(' '),
                Text('__Min'),
              ],
            ),
          ],
        ),
        trailing: Column(
          children: <Widget>[
            Text("Check Out"),
            Text("Time"),
            Text("__:__ AM"),
          ],
        ),
        onTap: () {},
    );
  }
}
