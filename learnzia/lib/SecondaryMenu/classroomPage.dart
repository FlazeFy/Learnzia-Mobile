import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetChannelname.dart';
import 'package:learnzia/Firebase/Classroom/GetChatOnChannel.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Widgets/sidebar.dart';
import 'package:learnzia/main.dart';


class ClassroomPage extends StatefulWidget {
  const ClassroomPage({key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override

  _ClassroomPage createState() => _ClassroomPage();
}

class _ClassroomPage extends State<ClassroomPage> {
  final _messageTextCtrl = TextEditingController();

  CollectionReference message= FirebaseFirestore.instance.collection('classroom-message');

  //Create account.
  Future<void> sendChat() {
    return message
      .add({
        'body': _messageTextCtrl.text, 
        'id_channel': passIdChannel, 
        'id_classroom': widget.passIdClass, 
        'id_user': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'type': 'text', // for now. 
      })
      .then((value) => print("Chat has been sended"))
      .catchError((error) => print("Failed to send chat: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme:  
          const IconThemeData(
          color: Color(0xFF313436),
          size: 35.0,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              //
            },
            child: Container(
              width: fullWidth*0.75,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [ 
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/User.jpg', width: 40),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetClassname(passDocumentId: widget.passIdClass, textColor: const Color(0xFF010C10)),
                      GetChannelName(passDocumentId: passIdChannel, textColor: const Color(0xFF7289DA))
                    ]
                  )
                ]
              )    
            )
          ),
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.home),
              color: containerColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
            ),
          ),
        ],  
        backgroundColor: mainColor,
      ),
      drawer: NavDrawer(passIdClass: widget.passIdClass),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: GetChatOnChannel(classId: widget.passIdClass)
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: containerColor,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: _messageTextCtrl,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: InputBorder.none
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: () async{
                        sendChat();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClassroomPage(passIdClass: widget.passIdClass)),
                        );
                      },
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Colors.green,
                      elevation: 0,
                    ),
                  ],
                  
                ),
              ),
            ),
          ], 
      
        ),
      )
    );
  }
}