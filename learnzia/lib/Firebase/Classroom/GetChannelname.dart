import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetChannelName extends StatefulWidget {
  @override
  GetChannelName({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _GetChannelNameState createState() => _GetChannelNameState();
}

class _GetChannelNameState extends State<GetChannelName> {
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
            if(document.id == widget.passDocumentId){
              return RichText(
                text: TextSpan(                     
                  text: "#${data['channel_name']}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: widget.textColor,
                    fontSize: 15,
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