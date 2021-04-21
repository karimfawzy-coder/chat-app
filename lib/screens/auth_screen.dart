import 'dart:io';

import 'file:///E:/Study/flutter_projects/chat_app/lib/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false ;
  void _submitAuthForm(String email, String password, String userName, File pickedImage,
      bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        //signUp
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
       // ref get access to the root bucket
        // child allow us to set up a new path
        // this all is a pointer to storage
       final storageRef = FirebaseStorage.instance.ref()
            .child('user_image')
            .child(authResult.user.uid +'.jpg');

      await storageRef.putFile(pickedImage).onComplete;
    final imageUrl = await storageRef.getDownloadURL();
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': userName,
          'email': email,
          'image_url' : imageUrl
        });
      }
    }
    // platform exception is the err that are thrown by firebase
    on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm , _isLoading ),
    );
  }
}
