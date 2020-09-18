import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceHistoryCard extends StatefulWidget {
  @override
  _AttendanceHistoryCardState createState() => _AttendanceHistoryCardState();
}

class _AttendanceHistoryCardState extends State<AttendanceHistoryCard> {
  final User loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('attendance')
                .doc(loggedInUser.uid)
                .collection('logInTime')
                .orderBy('stamp',descending: true)
                .snapshots(),
            builder: (context, snapshot1) {
              if (!snapshot1.hasData) {
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
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('attendance')
                        .doc(loggedInUser.uid)
                        .collection('logOutTime')
                        .orderBy('stamp',descending: true)
                        .snapshots(),
                    builder: (context, snapshot2) {
                      if (!snapshot2.hasData) {
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
                        return ListView.builder(
                            itemCount: snapshot2.data.documents.length,
                            itemBuilder: (ctx, index) {
                              DocumentSnapshot logInData =
                                  snapshot1.data.documents[index + 1];
                              DocumentSnapshot logOutData =
                                  snapshot2.data.documents[index];
                              return ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Time In'),
                                    Text('${logInData.data()['time']}'),
                                  ],
                                ),
                                title: Row(
                                  children: <Widget>[
                                    Icon(Icons.calendar_today, size: 16),
                                    SizedBox(width: 5),
                                    Text('${logInData.data()['date']}'),
                                  ],
                                ),
                                subtitle: Text('${logInData.data()['day']}'),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Time Out'),
                                    Text('${logOutData.data()['time']}'),
                                  ],
                                ),
                                onTap: () {},
                              );
                            });
                      }
                    });
              }
            }),
      ),
    );
  }
}
