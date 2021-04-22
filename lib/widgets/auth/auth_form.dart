import 'dart:io';

import 'package:chat_app/Animation/FadeAnimation.dart';
import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String userName,
    File pickedImage,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthForm;
  final bool _isLoading;

  AuthForm(this.submitAuthForm, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    // it will triggers all the validators of all textFormField
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // close the soft Keyboard
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }
    if (isValid) {
      // it will triggers all the onSaved method of all textFormField
      _formKey.currentState.save();
      // Use those values to send our auth request to firebase
      widget.submitAuthForm(_userEmail.trim(), _userPassword.trim(),
          _userName.trim(), _userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: height * 0.45,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -40,
                  height: height * 0.42,
                  width: width,
                  child: FadeAnimation(
                      1,
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background.png'),
                                fit: BoxFit.fill)),
                      )),
                ),
                Positioned(
                  height: height * 0.3,
                  width: width + 20,
                  child: FadeAnimation(
                      1.3,
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/background-2.png'),
                                fit: BoxFit.fill)),
                      )),
                )
              ],
            ),
          ),
          FadeAnimation(
                1.9,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 40,
                        )
                      ]),
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (!_isLogin)
                              UserImagePicker(
                                pickImageFn: _pickedImage,
                              ),
                            TextFormField(
                              key: ValueKey('email'),
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              validator: (value) {
                                if (value.isEmpty || !value.contains('@')) {
                                  return 'Please enter a valid email!';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                              onSaved: (value) {
                                _userEmail = value;
                              },
                            ),
                            if (!_isLogin)
                              TextFormField(
                                key: ValueKey('username'),
                                autocorrect: true,
                                textCapitalization: TextCapitalization.words,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 4) {
                                    return 'Please enter at least 4 characters';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                onSaved: (value) {
                                  _userName = value;
                                },
                              ),
                            TextFormField(
                              key: ValueKey('password'),
                              validator: (value) {
                                if (value.isEmpty || value.length < 7) {
                                  return 'Please enter at least 7 characters';
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onSaved: (value) {
                                _userPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            if (widget._isLoading) CircularProgressIndicator(),
                            if (!widget._isLoading)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(49, 39, 79, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                ),
                                child: Text(_isLogin ? 'Login' : 'SignUp'),
                                onPressed: _trySubmit,
                              ),
                            if (!widget._isLoading)
                              TextButton(
                                style: ElevatedButton.styleFrom(
                                  onPrimary: Color.fromRGBO(49, 39, 79, 1),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                ),
                                child: Text(_isLogin
                                    ? 'create a new account'
                                    : 'I already have an account'),
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
