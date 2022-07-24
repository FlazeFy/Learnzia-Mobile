import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLastReplyMessage extends StatelessWidget {
  GetLastReplyMessage({Key key, this.passIdReply, this.textColor}) : super(key: key);
  final String passIdReply;
  var textColor;

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('reply').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(document.id == passIdReply){
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(                     
                    text: data['body'],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
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