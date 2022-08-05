import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:learnzia/Firebase/Forum/GetQuestionOnReply.dart';
import 'package:learnzia/Firebase/Forum/GetReply.dart';
import 'package:learnzia/main.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key key, this.passIdDisc, this.id_user}) : super(key: key);
  final String passIdDisc;
  final String id_user;

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final _replyTextCtrl = TextEditingController();

  CollectionReference reply = FirebaseFirestore.instance.collection('reply');

  //send reply.
  Future<void> sendReply() {
    return reply
      .add({
        'body': _replyTextCtrl.text, 
        'id_discussion': widget.passIdDisc, 
        'id_user': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'type': 'text', // for now. 
        'image': 'null', // for now. 
        'status': 'null', 
      })
      .then((value) => print("Reply has been sended"))
      .catchError((error) => print("Failed to send reply: $error"));
  }
  
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme:  
          const IconThemeData(
          color: Color(0xFF313436),
          size: 35.0,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 5, right: fullWidth*0.45),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Reply Discussion", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
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
      body: Column(
        children:[
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 10),
          //   child: GetQuestionOnReply(passIdDisc: widget.passIdDisc),
          // ),
          Flexible(
            child: GetReply(passIdDisc: widget.passIdDisc, id_user: widget.id_user)
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
                    onTap: () async {
                      //Bug : not close after back button is pressed
                      FullScreenMenu.show(
                        context,
                        backgroundColor: Colors.transparent,
                        items: [
                          FSMenuItem(
                            icon: Icon(Icons.mic, color: Colors.white),
                            text: Text('Audio', style: TextStyle(color: mainColor)),
                            gradient: blueGradient,
                          ),
                          FSMenuItem(
                            icon: Icon(Icons.file_copy, color: Colors.white),
                            text: Text('Document', style: TextStyle(color: mainColor)),
                            gradient: purpleGradient,
                          ),
                          FSMenuItem(
                            icon: Icon(Icons.image, color: Colors.white),
                            text: Text('Image', style: TextStyle(color: mainColor)),
                            gradient: redGradient,
                          ),
                        ],
                      );
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
                      controller: _replyTextCtrl,
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
                      sendReply();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReplyPage(passIdDisc: widget.passIdDisc)),
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
        ]
      )
      
    );
  }
}