import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHAT APP',
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.pink,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: StreamBuilder(
        // it means listen when user login or logout or signUp
        stream: FirebaseAuth.instance.onAuthStateChanged ,
        builder: (ctx , userSnapShot){
          // means did find a token (found some valid data)
         if (userSnapShot.connectionState == ConnectionState.waiting){
           return SplashScreen();
         }
          if(userSnapShot.hasData)
            {
              return ChatScreen();
            }
          return AuthScreen();
        } ,
      ),
    );
  }
}
