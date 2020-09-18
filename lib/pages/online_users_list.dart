import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineUsersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('status', isEqualTo: 'online')
            .snapshots(),
        builder: (context, snapshot) {
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
            return GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5 / 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot user = snapshot.data.documents[index];
                  String status = user.data()['status'].toString();
                  String online = 'online';
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: GridTile(
                      child: GestureDetector(
                        onTap: () {},
                        child: FadeInImage(
                            placeholder: AssetImage('images/person_icon.png'),
                            image: NetworkImage('${user.data()['url']}'),
                            fit: BoxFit.cover),
                      ),
                      header: GridTileBar(
                        backgroundColor: Colors.black.withOpacity(0),
                        leading: status == online
                            ? Icon(Icons.wifi, color: Colors.teal)
                            : Icon(Icons.signal_wifi_off, color: Colors.red),
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black.withOpacity(0.7),
                        title: Text(
                            '${user.data()['firstName']} ${user.data()['lastName']}'),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
