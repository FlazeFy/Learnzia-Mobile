import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class CountUp extends StatefulWidget {
  @override
  CountUp({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountUpState createState() => _CountUpState();
}

class _CountUpState extends State<CountUp> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('up').snapshots();

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
            if(data['id_context'] == widget.passDocumentId){
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