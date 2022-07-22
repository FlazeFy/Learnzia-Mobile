import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetStatus extends StatefulWidget {
  @override
  GetStatus({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetStatusState createState() => _GetStatusState();
}

class _GetStatusState extends State<GetStatus> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();
  var textColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(document.id == widget.passDocumentId){
              if(data['status'] == "offline"){
                textColor = Colors.red;
              } else {
                textColor = Colors.green;
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(                     
                    text: data['status'],
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    )
                  ),                              
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