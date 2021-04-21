import 'package:chat_app/widgets/messages/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapShot) {
              if (chatSnapShot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userId = futureSnapShot.data.uid;
              final chatMessages = chatSnapShot.data.documents;
              return ListView.builder(
                reverse: true,
                itemCount: chatMessages.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  message: chatMessages[index]['text'],
                  isMe: chatMessages[index]['userId'] == userId,
                  key: ValueKey(chatMessages[index].documentID),
                  username: chatMessages[index]['username'],
                  userImage:chatMessages[index]['user_image'],
                ),
              );
            });
      },
    );
  }
}
