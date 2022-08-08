import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetChannelname.dart';
import 'package:learnzia/main.dart';

class GetLastChannelMessage extends StatefulWidget {
  @override
  GetLastChannelMessage({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetLastChannelMessageState createState() => _GetLastChannelMessageState();
}

class _GetLastChannelMessageState extends State<GetLastChannelMessage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('classroom-message').orderBy('datetime', descending: true).snapshots();

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

        int i = 0;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((data['id_channel'] == widget.passDocumentId)&&(data['type'] == 'text')&&(i == 0)){
              i++;
              return RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(                     
                      text: data['body'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );
            } else if((data['id_channel'] == widget.passDocumentId)&&(data['type'] == 'image')&&(i == 0)){
              i++;
              return Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.image, size: 16, color: Colors.white),
                      ),
                      TextSpan(
                        text: " Image", style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
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