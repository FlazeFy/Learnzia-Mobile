

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetChat extends StatefulWidget {
  const GetChat({Key key, this.contactId}) : super(key: key);
  final String contactId;

  @override
    _GetChatState createState() => _GetChatState();
}

class _GetChatState extends State<GetChat> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('message').orderBy('datetime', descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          padding: const EdgeInsets.only(top: 10),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getDate(){
              var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
              var date = DateTime.parse(dt);
              var formattedDate = "${date.hour} : ${date.minute}";
              return Container(
                margin: const EdgeInsets.only(top: 2),
                  child: Text(formattedDate, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 11)
                )
              );
            }
            if(data['id_user_sender'] == '0Xnz2jIQf3BLk7MZ9jiA'){
              return Column(
                children: [
                  BubbleSpecialThree(
                    text: data['body'],
                    color: containerColor,
                    tail: true,
                    isSender: true,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 30),
                    alignment: Alignment.centerRight,
                    child: getDate(),
                  )
                ]
              );
            } else {
              return Column(
                children: [
                  BubbleSpecialThree(
                    text: data['body'],
                    color: containerColor,
                    tail: true,
                    isSender: false,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 30),
                    alignment: Alignment.centerLeft,
                    child: getDate(),
                  )
                ]
              );
            }
          }).toList(),
        );
      },
    );
  }
}