import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetMyInvitation extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('invitation').orderBy('datetime', descending: false).snapshots();

  GetMyInvitation({Key key}) : super(key: key);

  CollectionReference rel= FirebaseFirestore.instance.collection('classroom-relation');
  CollectionReference contact= FirebaseFirestore.instance.collection('contact');
  CollectionReference invt= FirebaseFirestore.instance.collection('invitation');

  Future<void> joinClass(String idClass) {
    return rel
      .add({
        'id_classroom': idClass, 
        'id_user': passIdUser, 
        'role': 'member', 
      })
      .then((value) => print("Successfully join classroom"))
      .catchError((error) => print("Failed to join class: $error"));
  }

  Future<void> addToContact(String idClass) {
    return contact
      .add({
        'id_user_1': passIdUser, 
        'id_user_2': idClass, 
        'type': 'classroom', 
      })
      .then((value) => print("Successfully add to contact"))
      .catchError((error) => print("Failed to add contact: $error"));
  }

  Future<void> rejectInvitation(String idInvitation) {
    return invt
      .doc(idInvitation)
      .delete()
      .then((value) => print("Successfully reject invitation"))
      .catchError((error) => print("Failed to delete invitation: $error"));
  }

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
                                  const Text("Invite you to join ", style: const TextStyle(color: Colors.white)),
                                  GetClassname(passDocumentId: data['id_context'], textColor: const Color(0xFF7289DA))
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
                                      onPressed: () async {
                                        joinClass(data['id_context']);
                                        addToContact(data['id_context']);
                                        rejectInvitation(document.id);
                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Success', style: TextStyle(fontWeight: FontWeight.bold)),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      child: Image.asset(
                                                        'assets/icons/Channel.png', width: 20),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text("Congratulations, you are now a member of ", style: TextStyle(color: mainColor)),
                                                        GetClassname(passDocumentId: data['id_context'], textColor: mainColor)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Continue'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          }
                                        );
                                      }
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
                                      onPressed: () async {
                                        rejectInvitation(document.id);
                                        return showDialog<void>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Success', style: TextStyle(fontWeight: FontWeight.bold)),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      child: Image.asset(
                                                        'assets/icons/success.png', width: 20),
                                                    ),
                                                    Text("You have rejected the invitation", style: TextStyle(color: mainColor)),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Continue'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          }
                                        );
                                      }
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
              return const SizedBox();
            }
                    
          }).toList(),
        );
      },
    );
  }
}

