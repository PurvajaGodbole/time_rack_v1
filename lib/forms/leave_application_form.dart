import 'package:flutter/material.dart';

class LeaveApplicationForm extends StatefulWidget {
  @override
  _LeaveApplicationFormState createState() => _LeaveApplicationFormState();
}

class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(2),
          child: Text('Apply for leave'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('From'),
            RaisedButton(
              child: Text('Select'),
              onPressed: () {},
            ),
            SizedBox(width: 20),
            Text('To'),
            RaisedButton(
              child: Text('Select'),
              onPressed: () {},
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Number of days on leave'),
              Text(' - '),
              Text(' '),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Type of leave'),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Icon(Icons.check_box_outline_blank),
            SizedBox(width: 5),
            Text('Medical Leave'),
            SizedBox(width: 10),
            Icon(Icons.check_box_outline_blank),
            SizedBox(width: 5),
            Text('Annual Leave'),
            SizedBox(width: 10),
            Icon(Icons.check_box_outline_blank),
            SizedBox(width: 5),
            Text('Casual Leave'),
          ],
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(2),
          child: TextFormField(
            decoration: InputDecoration(
              icon: Icon(
                Icons.mail_outline,
              ),
              labelText: 'Message to Manager / Admin (optional)',
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(4),
          child: RaisedButton.icon(
            icon: Icon(
              Icons.touch_app,
              size: 15,
              color: Colors.white,
            ),
            label: Text(
              'Submit',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.purple,
            onPressed: () {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
