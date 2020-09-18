import 'package:flutter/material.dart';

import '../screens/office_mates_screen.dart';

class OfficeMatesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.group,
              color: Colors.indigo,
              size: 50,
            ),
            title: Text('Office Mates'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Online Members: __'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed(OfficeMatesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
