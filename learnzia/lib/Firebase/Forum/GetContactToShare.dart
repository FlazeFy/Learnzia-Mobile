import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetCategory.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Firebase/Contact/GetLastClassMessage.dart';
import 'package:learnzia/Firebase/Contact/GetLastFriendMessage.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetContactToShare extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('contact').snapshots();

  CollectionReference message= FirebaseFirestore.instance.collection('message');

  //Create account.
  Future<void> sendChat(String idQuestion, String idContact) {
    return message
      .add({
        'body': idQuestion, 
        'id_contact': idContact, 
        'id_user_sender': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'type': passTypeSend,
      })
      .then((value) => print("Question has been forwaded"))
      .catchError((error) => print("Failed to forward question: $error"));
  }

  GetContactToShare({Key key, this.passIdQuestion, this.passTypeSend}) : super(key: key);
  final String passIdQuestion;
  final String passTypeSend;

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
            if(data['type'] == 'friend'){
              if((data['id_user_1'] == passIdUser)&&((data['id_user_2'] != passIdUser))){
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
                                GetUsername(passDocumentId: data['id_user_2'], textColor: const Color(0xFFF1c40f)),
                                GetLastFriendMessage(passDocumentId: document.id)
                              ]
                            )
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white, 
                                onPressed: () async {  
                                  sendChat(passIdQuestion, document.id);
                                },
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: mainColor,
                              ) 
                            ),
                          ), 
                        ]
                      ),    
                    )
                  ),
                  onTap: () { 
                    //
                  },                   
                );
              } else if((data['id_user_2'] == passIdUser)&&((data['id_user_1'] != passIdUser))){
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
                                GetUsername(passDocumentId: data['id_user_1'], textColor: const Color(0xFFF1c40f)),
                                GetLastFriendMessage(passDocumentId: document.id)
                              ]
                            )
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white, onPressed: () async {  
                                  sendChat(passIdQuestion, document.id);
                                },
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: mainColor,
                              ) 
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
                return const SizedBox();
              }
            } else if(data['type'] == 'classroom') {
              if((data['id_user_1'] == passIdUser)){
                return InkWell(
                  child: Card(
                    color: containerColor,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom:5),
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
                                Container(
                                  transform: Matrix4.translationValues(0, 5, 0),
                                  child: Stack(
                                    children:[
                                      Container(
                                        transform: Matrix4.translationValues(0, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.asset(
                                            'assets/images/User.jpg', width: 40),
                                        ),
                                      ),
                                      Container(
                                        transform: Matrix4.translationValues(25, 0, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(25),
                                          child: Image.asset(
                                            'assets/images/User.jpg', width: 40),
                                        ),
                                      ),
                                      Container(
                                        transform: Matrix4.translationValues(75, 20, 0),
                                        child: const Text("+25 more...", style: TextStyle(color: Colors.white, fontSize:12))
                                      ),
                                    ]
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    child: IconButton(
                                      icon: const Icon(Icons.send),
                                      color: Colors.white, 
                                      onPressed: () async {  
                                        sendChat(passIdQuestion, document.id);
                                      },
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: mainColor,
                                    ) 
                                  ),
                                ), 
                              ]
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(                 
                                child: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        GetClassname(passDocumentId: data['id_user_2'], textColor: const Color(0xFFF1c40f)),
                                        const Spacer(),
                                        GetCategory(passDocumentId: data['id_user_2'], textColor: Colors.white),
                                      ]
                                    ),
                                    GetLastClassMessage(passDocumentId: data['id_user_2'])
                                  ]
                                )
                              ),
                            ],
                          ),
                        ],
                      )
                    )
                  ),
                  onTap: () { 
                    //
                  },                   
                );
              } else {
                return const SizedBox();
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

