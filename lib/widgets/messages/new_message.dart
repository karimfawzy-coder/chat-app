import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textController = TextEditingController();
  var _enteredMessage = '';
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users').document(user.uid).get();
     Firestore.instance.collection('chat').add({
       'text' : _enteredMessage,
       'createdAt' : Timestamp.now(),
       'userId' : user.uid,
       'username': userData['username'],
       'user_image': userData['image_url'],
     });
     _textController.clear();
     _enteredMessage ='';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration: InputDecoration(
                labelText: 'Type your message...'
              ),
              onChanged: (value){
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(icon: Icon(Icons.send ),color: Theme.of(context).primaryColor,
          onPressed: _enteredMessage.trim().isEmpty? null : _sendMessage,)
        ],
      ),
    );
  }
}
