import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetButtonInvitation extends StatefulWidget {
  @override
  GetButtonInvitation({Key key, this.passIdClass, this.passIdFriend}) : super(key: key);
  final String passIdClass;
  final String passIdFriend;

  @override
    _GetButtonInvitationState createState() => _GetButtonInvitationState();
}

class _GetButtonInvitationState extends State<GetButtonInvitation> {
  CollectionReference rel= FirebaseFirestore.instance.collection('invitation');

  Future<void> sendInvitation(String id_friend) {
    return rel
      .add({
        'id_user_receiver': id_friend,
        'id_user_sender': passIdUser, 
        'id_context': widget.passIdClass, 
        'type': 'classroom', 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
      })
      .then((value) => print("Invitation success"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> resendInvitation(String id) {
    return rel
      .doc(id)
      .delete()
      .then((value) => print("Successfully resend invitation"))
      .catchError((error) => print("Failed to delete invitation: $error"));
  }
  
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('invitation').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        int i = 0;
        int count = 0;
        int total = snapshot.data.size;
        String id_invitation;

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((data['id_user_receiver'] == widget.passIdFriend)&&(data['id_context'] == widget.passIdClass)){
              id_invitation = document.id;
              count = 1;
              i++;
            } else {
              i++;
            }

            if(i == total){
              if(count == 1){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child:IconButton(
                    icon: const Icon(Icons.cancel),
                    color: Colors.redAccent,
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Attention'),
                        actions: <Widget>[
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text("Resend the invitation?", style: const TextStyle(color: Colors.black)),
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
                                  Spacer(),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        resendInvitation(id_invitation);
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
                                                    Text('Invitation has resend'),
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
                    borderRadius: BorderRadius.circular(6),
                  ) 
                );
              } else if(count == 0) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child:IconButton(
                    icon: const Icon(Icons.email),
                    color: Colors.white,
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text('Attention'),
                        actions: <Widget>[
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text("Invite friend to classroom?", style: const TextStyle(color: Colors.black)),
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
                                  Spacer(),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        sendInvitation(widget.passIdFriend);
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
                                                    Text('Invitation sent successfully'),
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
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ) 
                );
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