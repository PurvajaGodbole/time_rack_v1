import 'package:flutter/material.dart';

class UnderConstructionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('To be viewed by authorized person only'),
          SizedBox(height: 50),
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Under Construction...'),
        ],
      ),
    );
  }
}
