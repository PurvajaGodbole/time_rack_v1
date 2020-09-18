import 'package:flutter/material.dart';

import '../pages/online_users_list.dart';
import '../pages/all_users_list.dart';
import '../widgets/app_drawer.dart';

class OfficeSpaceGridViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            'Office Space',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.wifi,
                      color: Colors.lightGreen,
                    ),
                    SizedBox(width: 10),
                    Text('Online'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.perm_scan_wifi,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10),
                    Text('All'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            OnlineUsersList(),
            AllUsersList(),
          ],
        ),
      ),
    );
  }
}
