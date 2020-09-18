import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/office_space_screen.dart';

class OfficeSpaceCard extends StatelessWidget {
  final User loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'online')
            .snapshots(),
        builder: (context, snapshot1) {
          QuerySnapshot userdata = snapshot1.data;
          int usersNum = userdata.docs.length;
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(loggedInUser.uid)
                  .snapshots(),
              builder: (context, snapshot2) {
                DocumentSnapshot user = snapshot2.data;
                String userRole = user.data()['userRole'].toString();
                String admin = 'Admin';
                return userRole == admin
                    ? Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.teal,
                                  size: 50,
                                ),
                                title: Text('Office Space'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Online Members: $usersNum'),
                                  ],
                                ),
                                trailing:
                                    Icon(Icons.keyboard_arrow_right, size: 30),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(OfficeSpaceScreen.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container();
              });
        });
  }
}
