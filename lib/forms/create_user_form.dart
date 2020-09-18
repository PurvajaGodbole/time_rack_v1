import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateUserForm extends StatefulWidget {
  static const routeName = '/create-user';

  @override
  _CreateUserFormState createState() => _CreateUserFormState();
}

class _CreateUserFormState extends State<CreateUserForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  File _userImageFile;
  String _firstName = '';
  String _lastName = '';
  String _mobile = '';
  String _department = '';
  String _position = '';
  String _userRole = '';
  String _userEmail = '';
  String _userPassword = '';

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      _userImageFile = File(pickedImageFile.path);
    });
  }

  void _clickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      _userImageFile = File(pickedImageFile.path);
    });
  }

  void _submitCreateUserForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      UserCredential authResult;
      try {
        setState(() {
          _isLoading = true;
        });
        authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _userEmail, password: _userPassword);

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(_userImageFile).onComplete;

        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'url': url,
          'firstName': _firstName,
          'lastName': _lastName,
          'mobile': _mobile,
          'department': _department,
          'position': _position,
          'userRole': _userRole,
          'email': _userEmail,
          'password': _userPassword,
          'userID': authResult.user.uid,
          'userCreatedAt': DateTime.now().toIso8601String(),
          // 'status': 'online',
        });

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
          children: <Widget>[
            Builder(
              builder: (context) {
                return Stepper(
                  steps: <Step>[
                    Step(
                      isActive: _currentStep >= 0,
                      title: Text("User Image"),
                      subtitle: Text("Pick a Profile Image"),
                      content: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.5,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              backgroundImage: _userImageFile != null
                                  ? FileImage(_userImageFile)
                                  : AssetImage('images/person_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                FlatButton.icon(
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.grey,
                                  ),
                                  label: Text(
                                    'Pick a picture',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: _pickImage,
                                ),
                                FlatButton.icon(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                  label: Text(
                                    'Click a picture',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  onPressed: _clickImage,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Step(
                      isActive: _currentStep >= 0,
                      title: Text("Personal Details"),
                      subtitle: Text("Enter the user's Personal Data"),
                      content: Column(
                        children: [
                          TextFormField(
                            key: ValueKey('firstName'),
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Please enter at least 3 characters!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _firstName = value;
                            },
                          ),
                          TextFormField(
                            key: ValueKey('lastName'),
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty || value.length < 3) {
                                return 'Please enter at least 3 characters!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _lastName = value;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.date_range,
                              ),
                              labelText: 'Birth Date',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            key: ValueKey('mobile'),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.phone,
                              ),
                              labelText: 'Mobile',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid mobile number!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _mobile = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    Step(
                      isActive: _currentStep >= 0,
                      title: Text("Position Details"),
                      subtitle: Text("Enter the user's Role and Position"),
                      content: Column(
                        children: [
                          TextFormField(
                            key: ValueKey('department'),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.account_balance,
                              ),
                              labelText: 'Department',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              _department = value;
                            },
                          ),
                          TextFormField(
                            key: ValueKey('position'),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.widgets,
                              ),
                              labelText: 'Position',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              _position = value;
                            },
                          ),
                          TextFormField(
                            key: ValueKey('userRole'),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person_pin,
                              ),
                              labelText: 'Role',
                              labelStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please choose between "Admin", "Member" or "Guest"';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userRole = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    Step(
                      isActive: _currentStep >= 0,
                      title: Text("User Credentials"),
                      subtitle:
                          Text("Enter the user's Authentication Credentials"),
                      content: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ],
                  currentStep: _currentStep,
                  onStepContinue: _currentStep < 3
                      ? () => setState(() => _currentStep += 1)
                      : null,
                  onStepCancel: _currentStep > 0
                      ? () => setState(() => _currentStep -= 1)
                      : null,
                  onStepTapped: (int step) =>
                      setState(() => _currentStep = step),
                );
              },
            ),
            if (_isLoading) CircularProgressIndicator(),
            if (!_isLoading)
              RaisedButton.icon(
                onPressed: _submitCreateUserForm,
                icon: Icon(Icons.touch_app),
                label: Text('Submit'),
              ),
          ],
        ),
      ),
    );
  }
}
