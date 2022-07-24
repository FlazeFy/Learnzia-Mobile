

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnzia/Firebase/Forum/GetSharedQuestion.dart';
import 'package:learnzia/main.dart';

class GetChat extends StatefulWidget {
  const GetChat({Key key, this.contactId}) : super(key: key);
  final String contactId;

  @override
    _GetChatState createState() => _GetChatState();
}

class _GetChatState extends State<GetChat> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('message').orderBy('datetime', descending: false).snapshots();
  
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;

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
            if(data['type'] == 'text'){
              if((data['id_user_sender'] == passIdUser)&&(data['id_contact'] == widget.contactId)){
                return Column(
                  children: [
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
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: Container(
                              height: 145,
                              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:[
                                  Container(
                                    transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                                    child: IconButton(
                                      icon: Icon(Icons.close, color: mainColor),
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: data['body']));
                                      },
                                      icon: const Icon(Icons.copy, size: 18, color: Colors.white),
                                      label: const Text("Copy Message", style: TextStyle(color: Colors.white)),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: OutlinedButton.icon(
                                      onPressed: () async{
                                        CollectionReference message = FirebaseFirestore.instance.collection('message');
                                        
                                        return message
                                          .doc(document.id)
                                          .delete()
                                          .then((value) => Navigator.pop(context))
                                          .catchError((error) => print("Failed to delete chat: $error"));
                                      },
                                      icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                                      label: const Text("Delete Message", style: TextStyle(color: Colors.white)),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                                      ),
                                    )
                                  )
                                ]
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5, right: 30),
                      alignment: Alignment.centerRight,
                      child: getDate(),
                    )
                  ]
                );
              } else if((data['id_user_sender'] != passIdUser)&&(data['id_contact'] == widget.contactId)){
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
              } else {
                return SizedBox();
              }
            } else if(data['type'] == 'question') {
              if((data['id_user_sender'] == passIdUser)&&(data['id_contact'] == widget.contactId)){
                return Container(
                  transform: Matrix4.translationValues(fullWidth*0.1, 0.0, 0.0),
                  child: GetSharedQuestion(passIdQuestion: data['body'], topLeft: Radius.circular(55),topRight: Radius.circular(10))
                );
              } else if((data['id_user_sender'] != passIdUser)&&(data['id_contact'] == widget.contactId)){
                return Container(
                  transform: Matrix4.translationValues(fullWidth*-0.1, 0.0, 0.0),
                  child: GetSharedQuestion(passIdQuestion: data['body'], topLeft: Radius.circular(10),topRight: Radius.circular(55))
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}