

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Firebase/Contact/GetLastFriendMessage.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/SecondaryMenu/chatPage.dart';
import 'package:learnzia/main.dart';

class GetMyInvitation extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('invitation').orderBy('datetime', descending: false).snapshots();

  GetMyInvitation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: _diskusi,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return ListView(
          padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_user_receiver'] == passIdUser){
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
                              GetUsername(passDocumentId: data['id_user_sender'], textColor: const Color(0xFFF1c40f)),
                              Row(
                                children: [
                                  Text("Invite you to join ", style: TextStyle(color: Colors.white)),
                                  GetClassname(passDocumentId: data['id_context'], textColor: Color(0xFF7289DA))
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child:IconButton(
                                      icon: const Icon(Icons.check),
                                      color: Colors.white,
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Attention'),
                                          actions: <Widget>[
                                            Column(
                                              children: [
                                                const Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Accept the invitation?", style: TextStyle(color: Colors.black)),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.red, // Background color
                                                        ),
                                                        child: const Text("Cancel"),
                                                      )
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.green, // Background color
                                                        ),
                                                        child: const Text("Yes"),
                                                      )
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(6),
                                    ) 
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    child:IconButton(
                                      icon: const Icon(Icons.cancel),
                                      color: Colors.white,
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title: const Text('Attention'),
                                          actions: <Widget>[
                                            Column(
                                              children: [
                                                const Align(
                                                  alignment: Alignment.center,
                                                  child: Text("Accept the invitation?", style: TextStyle(color: Colors.black)),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.red, // Background color
                                                        ),
                                                        child: const Text("Cancel"),
                                                      )
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: Colors.green, // Background color
                                                        ),
                                                        child: const Text("Yes"),
                                                      )
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ) 
                                  )
                                ],
                              )
                            ]
                          ),
                        ),    
                      ]
                    )    
                  )
                ),
                onTap: () { 
                  //
                },                   
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

