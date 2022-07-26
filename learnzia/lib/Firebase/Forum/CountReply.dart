import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class CountReply extends StatefulWidget {
  @override
  CountReply({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountReplyState createState() => _CountReplyState();
}

class _CountReplyState extends State<CountReply> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('reply').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_discussion'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return Text(count.toString(), style: TextStyle(color: Colors.white));
              } else if(count == 0) {
                return Text("0", style: TextStyle(color: Colors.white));
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

class CountReply2 extends StatefulWidget {
  @override
  CountReply2({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountReply2State createState() => _CountReply2State();
}

class _CountReply2State extends State<CountReply2> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('reply').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_discussion'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if((i == max)&&(count > 0)){
              return Text(count.toString(), style: TextStyle(color: mainColor, fontSize: 13, fontStyle: FontStyle.italic));
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}