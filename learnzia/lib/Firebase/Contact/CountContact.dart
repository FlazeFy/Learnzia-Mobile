import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class CountContact extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('contact').snapshots();

  CountContact({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
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
        int count = 0;
        int total = snapshot.data.size;
        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['type'] == 'friend'){
              if((data['id_user_1'] == passIdUser)&&((data['id_user_2'] != passIdUser))){
                count++;
                i++;
              } else if((data['id_user_2'] == passIdUser)&&((data['id_user_1'] != passIdUser))){
                count++;
                i++;
              } else {
                i++;
              }
            } else if(data['type'] == 'classroom') {
              if((data['id_user_1'] == passIdUser)){
                count++;
                i++;
              } else {
                i++;
              }
            } else {
              i++;
            }

            if((i == total)&&(count != 0)){
              return Text("Showing ${count.toString()} Contact...",  
                style: const TextStyle(color: Color(0xFF212121), fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)
              );
            } else if((i == total)&&(count == 0)){
              return const Text("Showing 0 Contact...", 
                style: TextStyle(color: Color(0xFF212121), fontSize: 13, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)
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