import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/CountUp.dart';
import 'package:learnzia/main.dart';

class VoteButton extends StatefulWidget {
  @override
  VoteButton({Key key, this.passIdStories, this.passOption}) : super(key: key);
  final String passIdStories;
  final String passOption;

  @override
  _VoteButtonState createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {

  @override
  Widget build(BuildContext context) {
    CollectionReference voting = FirebaseFirestore.instance.collection('voting');

    Future<void> voteStories(String idQuestion) {
      return voting
        .add({
          'id_context': widget.passIdStories, 
          'id_user': passIdUser, 
          'voted': widget.passOption, 
          'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        })
        .then((value) => print("Successfully vote stories"))
        .catchError((error) => print("Failed to vote stories: $error"));
    }

    Future<void> unvoteStories() {
      String id_up;

      FirebaseFirestore.instance
      .collection('voting')
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if((doc["id_user"] == passIdUser)&&(doc["id_context"] == widget.passIdStories)){
            id_up = doc.id;
          }
        });

        return voting
          .doc(id_up)
          .delete()
          .then((value) => print("Successfully unvote stories"))
          .catchError((error) => print("Failed to unvote stories: $error"));
      });
    }

    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('voting').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        int i = 0;
        int count = 0;
        int max = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((document['id_context'] == widget.passIdStories)&&(data['voted'] == widget.passOption)){
              if(data['id_user'] == passIdUser){
                i++;
                count++;
              } else {
                i++;
              }
            } else {
              i++;
            }

            if(i == max){
              if(count > 0){
                return Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: fullWidth*0.4,
                  child: ElevatedButton.icon(
                    label: Text(widget.passOption),
                    icon: Icon(Icons.check, size: 20),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 11, 169, 11)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    onPressed: () async {
                      unvoteStories();
                    },
                  ),
                );
              } else if(count == 0) {
                return Container(
                  margin: const EdgeInsets.only(top: 3),
                  width: fullWidth*0.4,
                  child: ElevatedButton(
                    child: Text(widget.passOption),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    onPressed: () async {
                      voteStories(widget.passIdStories);
                    },
                  ),
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