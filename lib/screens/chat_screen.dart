import 'package:chat_app/widgets/messages/messages.dart';
import 'package:chat_app/widgets/messages/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// snapshot is amazing method whis allow us to setup al listener through
// the flutter SDK to our firebase database
// when data changed ther this will notified automatically

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final fbm = FirebaseMessaging.instance;
    // fbm.requestPermission();
    // FirebaseMessaging.onMessage.listen((message) {
    //   print(message);
    //   return;
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print(message);
    //   return;
    // });
    // fbm.subscribeToTopic('chat');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat APP'),
        actions: <Widget>[
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Theme.of(context).accentColor,
                    ),
                    Text('Logout')
                  ],
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // body: StreamBuilder(
      //   stream: Firestore.instance
      //       .collection('chats/TKndmpDrIdDTydhOG7j9/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapShot) {
      //     //streamSnapShot is the latestData is the latest snapshot we get from stream
      //     // streamSnapShot is our object that help us to access to received data
      //     if(streamSnapShot.connectionState == ConnectionState.waiting){
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = streamSnapShot.data.documents;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(10),
      //         child: Text(documents[index]['text']),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
