import 'package:flutter/material.dart';

class MessageSettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.chat, color: Colors.teal),
              title: Text('Messages Settings'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.mobile_screen_share, color: Colors.orange),
              title: Text('Notifications'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.data_usage, color: Colors.purple),
              title: Text('Data & Storage'),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
