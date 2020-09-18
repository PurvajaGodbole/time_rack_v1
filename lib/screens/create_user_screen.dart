import 'package:flutter/material.dart';

import '../forms/create_user_form.dart';
import '../widgets/app_drawer.dart';

class CreateUserScreen extends StatefulWidget {
  static const routeName = '/create-user';

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Create User',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.save),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: CreateUserForm(),
    );
  }
}
