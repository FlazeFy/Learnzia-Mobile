import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetVerifyButton extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('reply').where('id_user', isNotEqualTo: passIdUser).snapshots();

  GetVerifyButton({Key key, this.id_discussion, this.id_reply}) : super(key: key);
  final String id_discussion;
  final String id_reply;

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;

    CollectionReference users = FirebaseFirestore.instance.collection('reply');

    Future<void> verifyReply(String id) {
    return users
      .doc(id)
      .update({'status': 'verified'})
      .then((value) => print("Reply has been verified"))
      .catchError((error) => print("Failed to verified reply: $error"));
    }

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

        int i = 0;
        int found = 0;
        int total = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if((data['id_discussion'] == id_discussion)&&(data['status'] == 'verified')){
              found++;
              i++;
            } else {
              i++;
            }

            if((i == total)&&(found == 0)){
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: fullWidth*0.25,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check, color: Colors.green),
                  label: Text("Verify", style: TextStyle(color: Colors.green)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green, width: 2),
                      )
                    )
                  ),
                  onPressed: () async {
                    verifyReply(id_reply);
                  },
                ),
              );
            } else if((i == total)&&(found == 1)){
              return const SizedBox();
            } else {
              return const SizedBox();
            }
            
          }).toList(),
        );
      },
    );
  }
}