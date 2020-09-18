import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/update_user_screen.dart';
import '../screens/create_user_screen.dart';
import '../widgets/app_drawer.dart';

class ManageUsersScreen extends StatelessWidget {
  static const routeName = '/manage-users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Manage Users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.group_add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateUserScreen.routeName);
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            );
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                DocumentSnapshot user = snapshot.data.documents[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      backgroundImage: NetworkImage('${user.data()['url']}'),
                      ),
                    title: Text('${user.data()['firstName']} ${user.data()['lastName']}'),
                    subtitle: Text('${user.data()['email']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(UpdateUserScreen.routeName);
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }
            );
          }
          return null;
        }
      ),
    );
  }
}
