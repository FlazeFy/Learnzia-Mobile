import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetChannelname.dart';

class GetLastClassMessage extends StatefulWidget {
  @override
  GetLastClassMessage({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _GetLastClassMessageState createState() => _GetLastClassMessageState();
}

class _GetLastClassMessageState extends State<GetLastClassMessage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('classroom-message').orderBy('datetime', descending: true).limit(1).snapshots();

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
            if(data['id_classroom'] == widget.passDocumentId){
              return RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: GetChannelName(passDocumentId: data['id_channel']),
                    ),
                    TextSpan(                     
                      text: " ~ ${data['body']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )
                  ],
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