import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/GetQuestion.dart';

class MyPost extends StatefulWidget {
  const MyPost({Key key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  CollectionReference disc = FirebaseFirestore.instance.collection('discussion');
    
  var subjectCtrl = TextEditingController();
  var questionCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: fullHeight,
        child: Flexible(
          child:
            GetMyQuestion(),
        ),
      )
    );
  }
}