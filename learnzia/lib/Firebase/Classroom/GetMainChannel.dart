import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetMainChannel extends StatefulWidget {
  @override
  const GetMainChannel({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetMainChannelState createState() => _GetMainChannelState();
}

class _GetMainChannelState extends State<GetMainChannel> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('channel').snapshots();

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
            if((document.id == widget.passDocumentId)&&(data['channel_name'] == 'main')){
              passIdChannel = data['id_channel'];
              return const SizedBox();
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}