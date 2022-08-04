import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetMemberControl.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetMyRole extends StatefulWidget {
  @override
  const GetMyRole({Key key, this.passIdClass, this.passIdMember}) : super(key: key);
  final String passIdClass;
  final String passIdMember;

  @override
    _GetMyRoleState createState() => _GetMyRoleState();
}

class _GetMyRoleState extends State<GetMyRole> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _classrel = FirebaseFirestore.instance.collection('classroom-relation').where('id_classroom', isEqualTo: widget.passIdClass).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _classrel,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Row(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_user'] == passIdUser){
              if(data['role'] != "member"){
                return GetMemberControl(passIdClass: widget.passIdClass, passIdMember: widget.passIdMember, passRole: data['role']);
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }).toList(),
        );
      },
    );
  }
}