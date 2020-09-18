// import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../screens/attendance_summary_screen.dart';

class AttendanceSummaryCard extends StatefulWidget {
  @override
  _AttendanceSummaryCardState createState() => _AttendanceSummaryCardState();
}

class _AttendanceSummaryCardState extends State<AttendanceSummaryCard> {
  final User loggedInUser = FirebaseAuth.instance.currentUser;
  String _connectionStatus = '';
  String _wifiName = '';
  String _wifiBSSID = '';
  String _wifiIP = '';
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    String wifiName;
    String wifiBSSID;
    String wifiIP;
    switch (result) {
      case ConnectivityResult.wifi:

        try {
          wifiName = await Connectivity().getWifiName();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          wifiBSSID = await Connectivity().getWifiBSSID();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await Connectivity().getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result';
          _wifiName = '$wifiName';
          _wifiBSSID = '$wifiBSSID';
          _wifiIP = '$wifiIP';
          FirebaseFirestore.instance
              .collection('attendance')
              .doc(loggedInUser.uid)
              .collection('logInTime')
              .add({
            'date': DateFormat.yMMMMd().format(DateTime.now()),
            'day': DateFormat.EEEE().format(DateTime.now()),
            'stamp': DateTime.now().toIso8601String(),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(loggedInUser.uid)
              .set({'status': 'online'}, SetOptions(merge: true));
        });
        break;

      case ConnectivityResult.mobile:
        setState(() {
          _connectionStatus = '$result';
          _wifiName = 'N/A';
          _wifiBSSID = 'N/A';
          _wifiIP = 'N/A';
          FirebaseFirestore.instance
              .collection('attendance')
              .doc(loggedInUser.uid)
              .collection('logOutTime')
              .add({
            'date':
            DateFormat.yMMMMd().format(DateTime.now()),
            'day': DateFormat.EEEE().format(DateTime.now()),
            'stamp': DateTime.now().toIso8601String(),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(loggedInUser.uid)
              .set({'status': 'offline'}, SetOptions(merge: true));
        });
        break;

      case ConnectivityResult.none:
        setState(() {
          _connectionStatus = '$result';
          _wifiName = 'N/A';
          _wifiBSSID = 'N/A';
          _wifiIP = 'N/A';
          FirebaseFirestore.instance
              .collection('attendance')
              .doc(loggedInUser.uid)
              .collection('logOutTime')
              .add({
            'date':
            DateFormat.yMMMMd().format(DateTime.now()),
            'day': DateFormat.EEEE().format(DateTime.now()),
            'stamp': DateTime.now().toIso8601String(),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(loggedInUser.uid)
              .set({'status': 'offline'}, SetOptions(merge: true));
        });
        break;

      default:
        setState(() {
          _connectionStatus = '$result';
          _wifiName = 'N/A';
          _wifiBSSID = 'N/A';
          _wifiIP = 'N/A';
          FirebaseFirestore.instance
              .collection('attendance')
              .doc(loggedInUser.uid)
              .collection('logOutTime')
              .add({
            'date':
            DateFormat.yMMMMd().format(DateTime.now()),
            'day': DateFormat.EEEE().format(DateTime.now()),
            'stamp': DateTime.now().toIso8601String(),
            'time': DateFormat.jm().format(DateTime.now()),
          });
          FirebaseFirestore.instance
              .collection('users')
              .doc(loggedInUser.uid)
              .set({'status': 'offline'}, SetOptions(merge: true));
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.today,
          color: Colors.indigo,
          size: 50,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Attendance Summary'),
            Text('Connection Status: $_connectionStatus'),
            Text('Wifi Name: $_wifiName'),
            Text('Wifi BSSID: $_wifiBSSID'),
            Text('Wifi IP: $_wifiIP'),
          ],
        ),
        subtitle: _connectionStatus == 'ConnectivityResult.wifi'
            ? Text('You are currently ONLINE')
            : Text('You are currently OFFLINE'),
        trailing: _connectionStatus == 'ConnectivityResult.wifi'
            ? Icon(Icons.wifi, color: Colors.green)
            : Icon(Icons.signal_wifi_off, color: Colors.red),
        onTap: _connectionStatus == 'ConnectivityResult.wifi' ? null : null,
      ),
    );
  }
}
