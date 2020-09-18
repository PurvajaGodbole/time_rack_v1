import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/manage_users_screen.dart';
import '../screens/my_dashboard_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final User loggedInUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot user = snapshot.data;
          String userRole = user.data()['userRole'].toString();
          String admin = 'Admin';
          return Drawer(
            child: Column(
              children: <Widget>[
                AppBar(
                  title: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('${user.data()['url']}'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Welcome',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${user.data()['firstName']} ${user.data()['lastName']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  automaticallyImplyLeading: false,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.home, color: Colors.blue),
                          title:
                              Text('My Dashboard (${user.data()['userRole']})'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacementNamed(
                                MyDashboardScreen.routeName);
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.message, color: Colors.blue),
                          title: Text('Messages'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(MessagesScreen.routeName);
                          },
                        ),
                        if (userRole == admin)
                        Divider(),
                        if (userRole == admin)
                        ListTile(
                          leading: Icon(Icons.playlist_add, color: Colors.blue),
                          title: Text('Manage Users'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(ManageUsersScreen.routeName);
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.blue),
                          title: Text('Settings'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed(SettingsScreen.routeName);
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.exit_to_app, color: Colors.blue),
                          title: Text('Logout'),
                          onTap: () {
                            Navigator.of(context).pop();
                            FirebaseAuth.instance.signOut();
                            // FirebaseFirestore.instance
                            //     .collection('attendance')
                            //     .doc(loggedInUser.uid)
                            //     .collection('logOutTime')
                            //     .add({
                            //   'date':
                            //       DateFormat.yMMMMd().format(DateTime.now()),
                            //   'day': DateFormat.EEEE().format(DateTime.now()),
                            //   'stamp': DateTime.now().toIso8601String(),
                            //   'time': DateFormat.jm().format(DateTime.now()),
                            // });
                            // FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(loggedInUser.uid)
                            //     .set({'status': 'offline'}, SetOptions(merge: true));
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
