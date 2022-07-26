import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetUsernameRole.dart';
import 'package:learnzia/main.dart';

class GetUsername extends StatefulWidget {
  @override
  GetUsername({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _GetUsernameState createState() => _GetUsernameState();
}

class _GetUsernameState extends State<GetUsername> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();

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
                    text: data['username'],
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

class GetUsername2 extends StatefulWidget {
  @override
  GetUsername2({Key key, this.passDocumentId, this.passIdClass, this.textColor}) : super(key: key);
  final String passDocumentId;
  final String passIdClass;
  var textColor;

  @override
  _GetUsernameState2 createState() => _GetUsernameState2();
}

class _GetUsernameState2 extends State<GetUsername2> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();

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
                child: GetUsernameRole(passDocumentId: widget.passDocumentId, passIdClass: widget.passIdClass)
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