import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetLastQuestionMessage.dart';

class GetLastFriendMessage extends StatefulWidget {
  @override
  GetLastFriendMessage({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _GetLastFriendMessageState createState() => _GetLastFriendMessageState();
}

class _GetLastFriendMessageState extends State<GetLastFriendMessage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('message').orderBy('datetime', descending: true).limit(1).snapshots();

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
            if((data['id_contact'] == widget.passDocumentId)&&(data['type'] == 'text')){
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(                     
                    text: data['body'],
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 14,
                    )
                  ),                              
                ),
              );
            } else if((data['id_contact'] == widget.passDocumentId)&&(data['type'] == 'question')){
              return GetLastQuestionMessage(passIdQuestion: data['body'], textColor: Colors.white);
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}