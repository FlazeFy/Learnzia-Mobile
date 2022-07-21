import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetType extends StatefulWidget {
  @override
  const GetType({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _GetTypeState createState() => _GetTypeState();
}

class _GetTypeState extends State<GetType> {
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
              if(data['type'] == 'public'){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/icons/public.png', width: 25),
                  ),
                );
              } else if(data['type'] == 'private') {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.asset(
                      'assets/icons/private.png', width: 25),
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}