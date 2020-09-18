import 'package:flutter/material.dart';

import '../forms/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Container(
          //   child: Center(
          //     child: Image.asset(
          //       'images/aus_flag.jpg',
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.deepPurple[900],
                  Colors.purple[400],
                  Colors.grey[50],
                  Colors.blue[400],
                  Colors.indigo[900],
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.av_timer,
                      size: 50,
                      color: Colors.orange,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'TIME',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 6,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 3),
                        Text(
                          'rack',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 20,
                            letterSpacing: 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.1,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.04,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            AuthForm(),
                            SizedBox(height: MediaQuery.of(context).size.height *0.02),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'POWERED',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 3,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'BY',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 3,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(
                                    Icons.power_settings_new,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  'ADA',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'TECHNOLOGY',
                              style: TextStyle(
                                fontSize: 6,
                                color: Colors.black,
                                letterSpacing: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
