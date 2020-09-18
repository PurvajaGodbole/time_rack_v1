import 'package:flutter/material.dart';

import '../pages/office_space_mapview_page.dart';
import '../pages/office_space_gridview_page.dart';

class OfficeSpaceScreen extends StatefulWidget {
  static const routeName = '/office-space';

  @override
  _OfficeSpaceScreenState createState() => _OfficeSpaceScreenState();
}

class _OfficeSpaceScreenState extends State<OfficeSpaceScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    OfficeSpaceGridViewPage(),
    OfficeSpaceMapViewPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            title: Text('Grid View'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map View'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
