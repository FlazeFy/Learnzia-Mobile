import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CountFriends extends StatefulWidget {
  @override
  CountFriends({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _CountFriendsState createState() => _CountFriendsState();
}

class _CountFriendsState extends State<CountFriends> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('contact').where('type', isEqualTo: 'friend').snapshots();

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
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
        int total = snapshot.data.size;
        return Column( 
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_user_1'] == widget.passDocumentId){
              i++;
            } else if(data['id_user_2'] == widget.passDocumentId){
              i++;
            } else {
              return const SizedBox();
            }
            if(i == total){
              return Container(
                alignment: Alignment.centerRight,
                width: fullWidth*0.45,
                child: Text(i.toString(), maxLines: 1, overflow: TextOverflow.ellipsis, 
                  style: const TextStyle(color: Color(0xFF212121), fontSize: 22, fontWeight: FontWeight.bold)
                ),
              );
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}