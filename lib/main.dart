import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
      return MaterialApp(
        title: 'CHAT APP',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(49, 39, 79, 1),
          // accentColor: Colors.deepPurple,
          // backgroundColor: Colors.pink,
          // accentColorBrightness: Brightness.dark,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          // buttonTheme: ButtonTheme.of(context).copyWith(
          //   buttonColor: Colors.pink,
          //   textTheme: ButtonTextTheme.primary,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20)
          //   )
          // )
        ),
        home: appSnapshot.connectionState != ConnectionState.done ? SplashScreen() :
        StreamBuilder(
          // it means listen when user login or logout or signUp
          stream: FirebaseAuth.instance.authStateChanges() ,
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
    });

  }
}
