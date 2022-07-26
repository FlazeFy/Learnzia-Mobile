import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetUsernameRole extends StatefulWidget {
  @override
  GetUsernameRole({Key key, this.passDocumentId, this.passIdClass, this.passUsername}) : super(key: key);
  final String passDocumentId;
  final String passIdClass;
  final String passUsername;

  @override
  _GetUsernameRoleState createState() => _GetUsernameRoleState();
}

class _GetUsernameRoleState extends State<GetUsernameRole> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('classroom-relation').where('id_classroom', isEqualTo: widget.passIdClass).snapshots();

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
            if((data['id_user'] == widget.passDocumentId)&&(data['role'] == 'founder')){
              return Align(
                alignment: Alignment.centerLeft,
                child: ShowRole(passDocumentId: data['id_user'], textColor: mainColor)
              );
            } else if((data['id_user'] == widget.passDocumentId)&&(data['role'] == 'co-founder')){
              return Align(
                alignment: Alignment.centerLeft,
                child: ShowRole(passDocumentId: data['id_user'], textColor: Color(0xFF7289DA))
              );
            } else if((data['id_user'] == widget.passDocumentId)&&(data['role'] == 'member')){
              return Align(
                alignment: Alignment.centerLeft,
                child: ShowRole(passDocumentId: data['id_user'], textColor: Colors.white)
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

class ShowRole extends StatefulWidget {
  @override
  ShowRole({Key key, this.passDocumentId, this.textColor}) : super(key: key);
  final String passDocumentId;
  var textColor;

  @override
  _ShowRoleState createState() => _ShowRoleState();
}

class _ShowRoleState extends State<ShowRole> {

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();

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
                  text: data['username'],
                  style: TextStyle(
                    color: widget.textColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  )
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