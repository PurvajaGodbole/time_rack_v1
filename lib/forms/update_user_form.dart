import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateUserForm extends StatefulWidget {
  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  @override
  Widget build(BuildContext context) {
    final User loggedInUser = FirebaseAuth.instance.currentUser;
    final _formKey = GlobalKey<FormState>();
    bool _isLoading = false;
    File _userImageFile;
    String _userID = '';
    String _firstName = '';
    String _lastName = '';
    String _mobile = '';

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

    void _submitUpdateUserForm() async {
      final isValid = _formKey.currentState.validate();
      FocusScope.of(context).unfocus();

      if (isValid) {
        _formKey.currentState.save();
        UserCredential authResult;
        try {
          setState(() {
            _isLoading = true;
          });
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
            'userUpdatedAt' : DateTime.now().toIso8601String(),
          });
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox (height: 20),
                Row(
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
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
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
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone,
                    ),
                    labelText: 'Mobile',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.account_balance,
                    ),
                    labelText: 'Department',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.widgets,
                    ),
                    labelText: 'Position',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person_pin,
                    ),
                    labelText: 'Role',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  textInputAction: TextInputAction.next,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                    ),
                    labelText: 'Email ID',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20),
                if (_isLoading) CircularProgressIndicator(),
                if (!_isLoading)
                RaisedButton.icon(
                    onPressed: _submitUpdateUserForm,
                    icon: Icon(Icons.touch_app),
                    label: Text('Click To Submit'),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
