import 'dart:io';

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
  void _pickedImage(File image){
    _userImageFile = image;
  }

  void _trySubmit() {
    // it will triggers all the validators of all textFormField
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); // close the soft Keyboard
    if(_userImageFile == null && !_isLogin)
    {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image.'),
        backgroundColor: Theme.of(context).errorColor,
      )
      );
      return;
    }
    if (isValid) {
      // it will triggers all the onSaved method of all textFormField
      _formKey.currentState.save();
      // Use those values to send our auth request to firebase
      widget.submitAuthForm(
          _userEmail.trim(), _userPassword.trim(), _userName.trim(),_userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!_isLogin) UserImagePicker(pickImageFn: _pickedImage,),
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
                  decoration: InputDecoration(labelText: 'Email Address'),
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
                    decoration: InputDecoration(labelText: 'Username'),
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
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                    onPressed: _trySubmit,
                  ),
                if (!widget._isLoading)
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin
                        ? 'create a new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
