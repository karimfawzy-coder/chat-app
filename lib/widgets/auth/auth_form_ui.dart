import 'package:chat_app/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
class AuthFormUi extends StatefulWidget {
  final TextField customTextFiled ;

  AuthFormUi({this.customTextFiled});

  @override
  _AuthFormUiState createState() => _AuthFormUiState();
}

class _AuthFormUiState extends State<AuthFormUi> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1.5, Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                SizedBox(height: 30,),
                FadeAnimation(1.7, Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                                color: Colors.grey[200]
                            ))
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey)
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                SizedBox(height: 20,),
                FadeAnimation(1.7, Center(child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),))),
                SizedBox(height: 30,),
                FadeAnimation(1.9, Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(49, 39, 79, 1),
                  ),
                  child: Center(
                    child: Text("Login", style: TextStyle(color: Colors.white),),
                  ),
                )),
                SizedBox(height: 30,),
                FadeAnimation(2, Center(child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
