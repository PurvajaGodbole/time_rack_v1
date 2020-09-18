import 'package:flutter/material.dart';

import '../screens/leave_status_screen.dart';

class LeavesStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.beach_access,
              color: Colors.deepOrangeAccent,
              size: 50,
            ),
            title: Text('Leaves Status'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Leaves availed so far'),
                Text('ML - 5'),
                Text('AL - 9'),
                Text('CL - 0'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(LeaveStatusScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
