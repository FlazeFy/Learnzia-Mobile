import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetClassname extends StatefulWidget {
  @override
  GetClassname({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _GetClassnameState createState() => _GetClassnameState();
}

class _GetClassnameState extends State<GetClassname> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('classroom').snapshots();

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
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(                     
                    text: "/${data['classname']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: widget.textColor,
                      fontSize: 16,
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