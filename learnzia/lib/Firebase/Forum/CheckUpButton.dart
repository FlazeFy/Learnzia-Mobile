import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/CountUp.dart';
import 'package:learnzia/main.dart';

class CheckUpButton extends StatefulWidget {
  @override
  CheckUpButton({Key key, this.passDocumentId}) : super(key: key);
  final String passDocumentId;

  @override
  _CheckUpButtonState createState() => _CheckUpButtonState();
}

class _CheckUpButtonState extends State<CheckUpButton> {

  @override
  Widget build(BuildContext context) {
    CollectionReference up = FirebaseFirestore.instance.collection('up');

    Future<void> upQuestion(String idQuestion) {
      return up
        .add({
          'id_context': idQuestion, 
          'id_user': passIdUser, 
        })
        .then((value) => print("Successfully up question"))
        .catchError((error) => print("Failed up question: $error"));
    }

    Future<void> downQuestion() {
      String id_up;

      FirebaseFirestore.instance
      .collection('up')
      .get()
      .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if((doc["id_user"] == passIdUser)&&(doc["id_context"] == widget.passDocumentId)){
            id_up = doc.id;
          }
        });

        return up
          .doc(id_up)
          .delete()
          .then((value) => print("Successfully re-up question"))
          .catchError((error) => print("Failed to re-up question: $error"));
      });
    }

    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('up').snapshots();

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
            if(document['id_context'] == widget.passDocumentId){
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
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: fullWidth*0.25,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_upward),
                    label: CountUp(passDocumentId: widget.passDocumentId),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 11, 169, 11)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    onPressed: () async {
                      downQuestion();
                    },
                  ),
                );
              } else if(count == 0) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: fullWidth*0.25,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_upward),
                    label: CountUp(passDocumentId: widget.passDocumentId),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 226, 184, 14)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )
                      )
                    ),
                    onPressed: () async {
                      upQuestion(widget.passDocumentId);
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