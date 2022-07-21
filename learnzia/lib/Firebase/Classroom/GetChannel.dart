import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/SecondaryMenu/classroomPage.dart';
import 'package:learnzia/main.dart';

class GetChannel extends StatefulWidget {
  @override
  const GetChannel({Key key, this.passDocumentId, this.passIdClass}) : super(key: key);
  final String passDocumentId;
  final String passIdClass;

  @override
    _GetChannelState createState() => _GetChannelState();
}

class _GetChannelState extends State<GetChannel> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('channel').orderBy('datetime', descending: false).snapshots();

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

        return ListView(
          padding: EdgeInsets.zero,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_classroom'] == widget.passDocumentId){
              return ListTile(
                title: Text('#${data['channel_name']}', style: TextStyle(color: mainColor, fontSize: 16)),
                subtitle: Text(data['channel_description'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                onTap: () {
                  passIdChannel = document.id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassroomPage(passIdClass: widget.passIdClass)),
                  );
                },
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