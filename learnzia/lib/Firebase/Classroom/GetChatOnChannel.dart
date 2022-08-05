

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
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

        //Store date chip n-1 index (before)
        String dateChipBefore = "";
        String timeBefore = "";
        
        return ListView(
          padding: const EdgeInsets.only(top: 10),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getTime(){
              var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
              var date = DateTime.parse(dt);
              String check = "${date.hour} : ${date.minute}";

              if(timeBefore != check){
                timeBefore = check;
                return Container(
                  margin: const EdgeInsets.only(top: 2),
                    child: Text(check, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 11)
                  )
                );
              } else {
                return const SizedBox();
              }
            }

            //Get file
            Widget getUrl(double left, double right){
              if(data['url'] != 'null'){
                return Container( 
                  width: fullWidth*0.5,
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.only(right: right, left: left, bottom: 5, top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(data['url']),
                  ),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                );
              } else {
                return const SizedBox();
              }
            }

            Widget getBody(bool person){
              if(data['body'] != ""){
                return BubbleSpecialThree(
                  text: data['body'],
                  color: containerColor,
                  tail: true,
                  isSender: person,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                );
              } else {
                return const SizedBox();
              } 
            }

            Widget getDateChip(){
              var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
              var date = DateTime.parse(dt);

              String check = ("${date.year}${date.month}${date.day}");
              if(dateChipBefore != check){
                dateChipBefore = check;

                return Container(
                  alignment: Alignment.center,
                  child: DateChip(
                    date: DateTime(date.year, date.month, date.day),
                    color: const Color(0xFF7289DA).withOpacity(0.8),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }


            if((data['id_user'] == passIdUser)&&(data['id_channel'] == passIdChannel)){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getDateChip(),
                  getUrl(0, 20),
                  GestureDetector(
                    child: getBody(true),
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
                                      CollectionReference message = FirebaseFirestore.instance.collection('classroom-message');
                                      
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
                    child: getTime(),
                  )
                ]
              );
            } if((data['id_user'] != passIdUser)&&(data['id_channel'] == passIdChannel)){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getDateChip(),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, top: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/User.jpg', width: 35),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 5),
                          child: GetUsername2(passDocumentId: data['id_user'], passIdClass: widget.classId)
                        )
                      ],
                    )
                  ),
                  getUrl(20, 0),
                  GestureDetector(
                    child: getBody(false),
                    onLongPress: () {
                      
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 30),
                    alignment: Alignment.centerLeft,
                    child: getTime(),
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