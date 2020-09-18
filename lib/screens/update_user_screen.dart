import 'package:flutter/material.dart';

import '../forms/update_user_form.dart';
import '../widgets/app_drawer.dart';

class UpdateUserScreen extends StatefulWidget {
  static const routeName = '/update-user';

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Update User Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.assignment_ind),
          SizedBox(width: 10),
        ],
      ),
      body: UpdateUserForm(),
    );
  }
}
