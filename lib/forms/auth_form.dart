import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  bool _isLoading = false;

  void _submitSignInForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      UserCredential authResult;
      try {
        setState(() {
          _isLoading = true;
        });
        authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user.uid)
        //     .set({'status': 'online'}, SetOptions(merge: true));
        //
        // await FirebaseFirestore.instance
        //     .collection('attendance')
        //     .doc(authResult.user.uid)
        //     .collection('logInTime')
        //     .add({
        //   'date': DateFormat.yMMMMd().format(DateTime.now()),
        //   'day': DateFormat.EEEE().format(DateTime.now()),
        //   'stamp': DateTime.now().toIso8601String(),
        //   'time': DateFormat.jm().format(DateTime.now()),
        // });
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your credentials!';

        if (err.message != null) {
          message = err.message;
        }

        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        print(err);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              key: ValueKey('email'),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                ),
                labelText: 'Email ID',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty ||
                    !value.contains('@') ||
                    !value.contains('.com')) {
                  return 'Please enter a valid Email ID!';
                }
                return null;
              },
              onSaved: (value) {
                _userEmail = value;
              },
            ),
            TextFormField(
              key: ValueKey('password'),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty || value.length < 7) {
                  return 'Password must be at least 7 characters long!';
                }
                return null;
              },
              onSaved: (value) {
                _userPassword = value;
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading)
              RaisedButton(
                color: Colors.purple,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
                onPressed: _submitSignInForm,
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.contact_phone),
              label: Text('Contact Admin For User Registration'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
