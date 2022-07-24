import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/GetQuestionOnReply.dart';
import 'package:learnzia/Firebase/Forum/GetReply.dart';
import 'package:learnzia/main.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key key, this.passIdDisc}) : super(key: key);
  final String passIdDisc;

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
      })
      .then((value) => print("Reply has been sended"))
      .catchError((error) => print("Failed to send reply: $error"));
  }
  
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme:  
          const IconThemeData(
          color: Color(0xFF313436),
          size: 35.0,
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 5, right: fullWidth*0.5),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Reply Discussion", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
            )
          ),
        ],
        backgroundColor: mainColor,
      ),
      body: Column(
          children:[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: GetQuestionOnReply(passIdDisc: widget.passIdDisc),
            ),
            Flexible(
              child: GetReply(passIdDisc: widget.passIdDisc)
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