import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/update_user_screen.dart';

class UserDetailCard extends StatelessWidget {
  final User loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot user = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            );
          } else {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${user.data()['url']}'),
                ),
                title: Text(
                  '${user.data()['firstName']} ${user.data()['lastName']}',
                  // Need to retrieve data here...
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.mail_outline, size: 12),
                        SizedBox(width: 10),
                        Text('${user.data()['email']}'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone, size: 12),
                        SizedBox(width: 10),
                        Text('${user.data()['mobile']}'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.account_balance, size: 12),
                        SizedBox(width: 10),
                        Text('${user.data()['department']}'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.widgets, size: 12),
                        SizedBox(width: 10),
                        Text('${user.data()['position']}'),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(UpdateUserScreen.routeName);
                },
              ),
            );
          }
        });
  }
}
