import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/app_drawer.dart';

class MessagesScreen extends StatelessWidget {
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
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
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot user = snapshot.data.documents[index];
                    return Container(
                      padding: EdgeInsets.all(6),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            backgroundImage: NetworkImage('${user.data()['url']}'),
                          ),
                          title: Text('${user.data()['firstName']} ${user.data()['lastName']}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(Icons.settings_phone, size: 12),
                                  SizedBox(width: 5),
                                  Text('Ext.: ______'),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.mail_outline, size: 12),
                                  SizedBox(width: 5),
                                  Text('Email: ${user.data()['email']}'),
                                ],
                              ),
                            ],
                          ),
                          trailing:
                          Icon(Icons.signal_wifi_off, color: Colors.red),
                          onTap: () {},
                        ),
                      ),
                    );
                  });
            }
            return null;
          }),
    );
  }
}
