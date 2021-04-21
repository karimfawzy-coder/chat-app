import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String userImage;
  MessageBubble({this.message , this.isMe , this.key , this.username , this.userImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 140,
              decoration: BoxDecoration(
                color: isMe? Colors.cyan.shade900 : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: isMe? Radius.circular(0) : Radius.circular(12),
                  bottomLeft: isMe? Radius.circular(12) : Radius.circular(0),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 8,
              ),
              child:Column(
                crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username == null? '' :username,style: TextStyle(
                      color: !isMe? Colors.white : Colors.pinkAccent,
                      fontWeight: FontWeight.bold),),
                  Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: isMe ? TextAlign.end :TextAlign.start
                  ),
                ],
              ),
            ),
          ],

        ) ,
        Positioned(
          top: !isMe? 0 : null,
           left:!isMe? 120 : null,
            right: isMe? 120 : null,
            bottom: isMe? 40 : null,
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(userImage),
            ))

      ],
      // in recent versions of flutter ,
      // it change to clipBehavior.Clip.none
      overflow: Overflow.visible,

    ) ;
  }
}
