import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/GetQuestionOnReply.dart';
import 'package:learnzia/Firebase/Forum/GetReply.dart';
import 'package:learnzia/SecondaryMenu/TabController/createPost.dart';
import 'package:learnzia/SecondaryMenu/TabController/myPost.dart';
import 'package:learnzia/Widgets/customPainter.dart';
import 'package:learnzia/main.dart';

class ReplyPage extends StatefulWidget {
  const ReplyPage({Key key, this.passIdDisc}) : super(key: key);
  final String passIdDisc;

  @override
  _ReplyPageState createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  
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
      body: CustomPaint(
        painter : CurvedPainter2(),
        child : Container(
          padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 10),
          child: Column(
            children:[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: fullHeight*0.05),
                child: GetQuestionOnReply(passIdDisc: widget.passIdDisc),
              ),
              Flexible(
                child: GetReply(passIdDisc: widget.passIdDisc)
              )
            ]
          )
        )
      ),
    );
  }
}