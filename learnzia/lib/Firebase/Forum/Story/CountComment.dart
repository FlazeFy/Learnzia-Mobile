import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class CountComment extends StatefulWidget {
  @override
  CountComment({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CountCommentState createState() => _CountCommentState();
}

class _CountCommentState extends State<CountComment> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('stories-comment').snapshots();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_stories'] == widget.passDocumentId){
              i++;
              count++;
            } else {
              i++;
            }

            if(i == max){ 
              return Container(
                margin: const EdgeInsets.only(left: 10),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 15),
                    children: [
                      const TextSpan(
                        text: "Comment", 
                      ),
                      TextSpan(
                        text: " (${count.toString()})", 
                      ),
                    ]
                  )
                ),
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