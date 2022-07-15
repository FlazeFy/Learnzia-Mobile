import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetMiniProfile extends StatelessWidget {
  final String documentId;

  const GetMiniProfile(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            double fullWidth = MediaQuery.of(context).size.width;

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
          return Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset(
                  'assets/images/User.jpg', width: 140),
                ),
                const Spacer(),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin:const EdgeInsets.only(bottom: 15), 
                        child: Text(data['username'], style: const TextStyle(color: Color(0xFF212121), fontSize: 22, fontWeight: FontWeight.bold))
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: fullWidth*0.45,
                        child: Text(data['fullname'], maxLines: 1, overflow: TextOverflow.ellipsis, 
                          style: const TextStyle(color: Color(0xFF212121), fontSize: 16)
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: fullWidth*0.45,
                        child: Text(data['email'], maxLines: 1, overflow: TextOverflow.ellipsis, 
                          style: const TextStyle(color: Color(0xFF212121), fontSize: 16)
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        width: fullWidth*0.45,
                        child: Text(data['description'], maxLines: 3, overflow: TextOverflow.ellipsis, 
                          style: const TextStyle(color: Color(0xFF212121), fontSize: 14)
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF1C40F).withOpacity(0.9),
                  Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            )
          );
        }

        return const Text("loading");
      },
    );
  }
}