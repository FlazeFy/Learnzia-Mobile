import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetMemberControl extends StatefulWidget {
  @override
  const GetMemberControl({Key key, this.passIdClass, this.passIdMember, this.passRole}) : super(key: key);
  final String passIdClass;
  final String passIdMember;
  final String passRole;

  @override
    _GetMemberControlState createState() => _GetMemberControlState();
}

class _GetMemberControlState extends State<GetMemberControl> {
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

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getPromote(){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String role;
                    CollectionReference class_rel = FirebaseFirestore.instance.collection('classroom-relation');

                    if(data['role'] == 'co-founder'){
                      role = "founder";

                      //Change class founder
                      FirebaseFirestore.instance
                      .collection('classroom-relation')
                      .where('id_classroom', isEqualTo: widget.passIdClass)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                          querySnapshot.docs.forEach((doc) {
                            if(doc["id_user"] == passIdUser){
                              return class_rel
                                .doc(doc.id)
                                .update({
                                  'role': 'co-founder', 
                                })
                                .then((value) => print("Successfully edit member's role"))
                                .catchError((error) => print("Failed to update role: $error"));
                            }});
                          }
                      );
                    } else {
                      role = "co-founder";
                    }
                      return class_rel
                        .doc(document.id)
                        .update({
                          'role': role, 
                        })
                        .then((value) => print("Successfully edit member's role"))
                        .catchError((error) => print("Failed to update role: $error"));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                  ),
                  child: Text("Promote", style: TextStyle(fontSize: 13)),
                )
              );
            }
            Widget getDemote(){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () async {
                    CollectionReference class_rel = FirebaseFirestore.instance.collection('classroom-relation');

                    return class_rel
                      .doc(document.id)
                      .update({
                        'role': 'member', 
                      })
                      .then((value) => print("Successfully edit member's role"))
                      .catchError((error) => print("Failed to update role: $error"));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
                  ),
                  child: Text("Demote", style: TextStyle(fontSize: 13)),
                )
              );
            }
            Widget getKick(){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  onPressed: () async {
                    CollectionReference class_rel = FirebaseFirestore.instance.collection('classroom-relation');

                    return class_rel
                      .doc(document.id)
                      .delete()
                      .then((value) => print("Successfully edit member's role"))
                      .catchError((error) => print("Failed to update role: $error"));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Background color
                  ),
                  child: Text("Kick", style: TextStyle(fontSize: 13)),
                )
              );
            }
            if((data['id_user'] == widget.passIdMember)&&(data['id_user'] != passIdUser)){
              if(widget.passRole == 'founder'){
                if(data['role'] == 'co-founder'){
                  return RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: getPromote()
                        ),
                        WidgetSpan(
                          child: getDemote()
                        ),
                      ],
                    ),
                  );
                } else {
                  return RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: getPromote()
                        ),
                        WidgetSpan(
                          child: getKick()
                        ),
                      ],
                    ),
                  );
                }
              } else {
                if(data['role'] == 'member'){
                  return RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: getPromote()
                        ),
                        WidgetSpan(
                          child: getKick()
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
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