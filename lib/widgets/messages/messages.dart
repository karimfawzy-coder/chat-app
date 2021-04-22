import 'package:chat_app/widgets/messages/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapShot) {
          if (chatSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userId = user.uid;
          final chatMessages = chatSnapShot.data.docs;
          return ListView.builder(
            reverse: true,
            itemCount: chatMessages.length,
            itemBuilder: (ctx, index) => MessageBubble(
              message: chatMessages[index].data()['text'],
              isMe: chatMessages[index].data()['userId'] == userId,
              key: ValueKey(chatMessages[index].id),
              username: chatMessages[index].data()['username'],
              userImage: chatMessages[index].data()['user_image'],
            ),
          );
        });
  }
}
