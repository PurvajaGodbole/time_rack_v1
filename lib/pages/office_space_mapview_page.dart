import 'package:flutter/material.dart';

import '../pages/under_construction_page.dart';
import '../widgets/app_drawer.dart';

class OfficeSpaceMapViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Office Space',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Shows Map View'),
          UnderConstructionPage(),
        ],
      ),
    );
  }
}
