

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetChatOnChannel extends StatefulWidget {
  const GetChatOnChannel({Key key, this.classId}) : super(key: key);
  final String classId;

  @override
    _GetChatOnChannelState createState() => _GetChatOnChannelState();
}

class _GetChatOnChannelState extends State<GetChatOnChannel> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('classroom-message').orderBy('datetime', descending: false).snapshots();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
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
            if((data['id_user'] == passIdUser)&&(data['id_channel'] == passIdChannel)){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/User.jpg', width: 35),
                    ),
                  ),
                  GestureDetector(
                    child: BubbleSpecialThree(
                      text: data['body'],
                      color: containerColor,
                      tail: true,
                      isSender: true,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    onLongPress: () {
                      
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 30),
                    alignment: Alignment.centerRight,
                    child: getDate(),
                  )
                ]
              );
            } if((data['id_user'] != passIdUser)&&(data['id_channel'] == passIdChannel)){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'assets/images/User.jpg', width: 35),
                    ),
                  ),
                  GestureDetector(
                    child: BubbleSpecialThree(
                      text: data['body'],
                      color: containerColor,
                      tail: true,
                      isSender: false,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    onLongPress: () {
                      
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 30),
                    alignment: Alignment.centerLeft,
                    child: getDate(),
                  )
                ]
              );
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}