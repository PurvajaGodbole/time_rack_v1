import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';
import './screens/create_user_screen.dart';
import './screens/office_space_screen.dart';
import './screens/office_mates_screen.dart';
import './screens/manage_users_screen.dart';
import './screens/update_user_screen.dart';
import './screens/leave_status_screen.dart';
import './screens/attendance_summary_screen.dart';
import './screens/settings_screen.dart';
import './screens/messages_screen.dart';
import './screens/my_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Rack',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        backgroundColor: Colors.purple[50],
        scaffoldBackgroundColor: Colors.purple[50],
        accentColor: Colors.orange,
        accentColorBrightness: Brightness.light,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.purple,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.purple,
          elevation: 4,
        ),
        cardTheme: CardTheme(
          color: Colors.purple[50],
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        ),
        dividerColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.grey),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.grey[900],
        scaffoldBackgroundColor: Colors.grey[900],
        accentColor: Colors.orange,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.blueGrey,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          elevation: 4,
        ),
        cardTheme: CardTheme(
          color: Colors.blueGrey[900],
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
        ),
        dividerColor: Colors.grey,
        iconTheme: IconThemeData(color: Colors.grey),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      themeMode: ThemeMode.system,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return MyDashboardScreen();
            }
            return AuthScreen();
          }),
      routes: {
        MyDashboardScreen.routeName: (ctx) => MyDashboardScreen(),
        MessagesScreen.routeName: (ctx) => MessagesScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
        AttendanceSummaryScreen.routeName: (ctx) => AttendanceSummaryScreen(),
        LeaveStatusScreen.routeName: (ctx) => LeaveStatusScreen(),
        UpdateUserScreen.routeName: (ctx) => UpdateUserScreen(),
        ManageUsersScreen.routeName: (ctx) => ManageUsersScreen(),
        OfficeMatesScreen.routeName: (ctx) => OfficeMatesScreen(),
        OfficeSpaceScreen.routeName: (ctx) => OfficeSpaceScreen(),
        CreateUserScreen.routeName: (ctx) => CreateUserScreen(),
      },
    );
  }
}
