import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetMember extends StatefulWidget {
  @override
  const GetMember({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
    _GetMemberState createState() => _GetMemberState();
}

class _GetMemberState extends State<GetMember> {
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

        return ListView(
          padding: const EdgeInsets.only(top: 0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getClassControl(){
              if(data['id_user'] == passIdUser){
                return const SizedBox();
              } 
              //NOT FINISHED
            }
            return InkWell(
              child: Card(
                color: containerColor,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                  child: Row(
                    children: [ 
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/User.jpg', width: 50),
                        ),
                      ),
                      Expanded(                 
                        child: Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetUsername(passDocumentId: data['id_user'], textColor: const Color(0xFFF1c40f)),
                            Text(data['role'], style: const TextStyle(color: Colors.white))
                          ]
                        )
                      ),
                      const Spacer(),
                      getClassControl()
                    ]
                  )    
                )
              ),
              onTap: () { 
                // 
              },                   
            );
          }).toList(),
        );
      },
    );
  }
}