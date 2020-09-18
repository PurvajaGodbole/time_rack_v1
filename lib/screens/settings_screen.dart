import 'package:flutter/material.dart';

import '../cards/account_settings_card.dart';
import '../cards/message_settings_card.dart';
import '../cards/user_detail_card.dart';
import '../widgets/app_drawer.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserDetailCard(),
            SizedBox(height: 40),
            MessageSettingsCard(),
            SizedBox(height: 40),
            AccountSettingsCard(),
          ],
        ),
      ),
    );
  }
}
