

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/SecondaryMenu/chatPage.dart';
import 'package:learnzia/main.dart';

class GetContact extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('contact').snapshots();

  GetContact({Key key}) : super(key: key);

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

        return ListView(
          padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getDate(){
              var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
              var date = DateTime.parse(dt);
              var formattedDate = "${date.day}-${date.month}-${date.year}";
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)
                )
              );
            }
            if((data['id_user_1'] == '0Xnz2jIQf3BLk7MZ9jiA')&&((data['id_user_2'] != '0Xnz2jIQf3BLk7MZ9jiA'))){
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
                              GetUsername(passDocumentId: data['id_user_2'], textColor: Color(0xFFF1c40f)),
                              RichText(
                                text: const TextSpan(                     
                                  text: 'lorem ipsum',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )
                                ),                              
                              )
                            ]
                          )
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: const Text(
                              "Today at 16:40", 
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ), 
                      ]
                    )    
                  )
                ),
                onTap: () { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage(passIdContact: document.id, passContactName: data['id_user_2'])),
                  );
                },                   
              );
            } else if((data['id_user_2'] == '0Xnz2jIQf3BLk7MZ9jiA')&&((data['id_user_1'] != '0Xnz2jIQf3BLk7MZ9jiA'))){
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
                              GetUsername(passDocumentId: data['id_user_1'], textColor: Color(0xFFF1c40f)),
                              RichText(
                                text: const TextSpan(                     
                                  text: 'lorem ipsum',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  )
                                ),                              
                              )
                            ]
                          )
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: const EdgeInsets.only(right: 10.0),
                            child: const Text(
                              "Today at 16:40", 
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ), 
                      ]
                    )    
                  )
                ),
                onTap: () { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage(passIdContact: document.id, passContactName: data['id_user_1'])),
                  );
                },                   
              );
            }
          }).toList(),
        );
      },
    );
  }
}

