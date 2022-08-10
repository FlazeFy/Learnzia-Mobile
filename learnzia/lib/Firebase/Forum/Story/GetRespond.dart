import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetRespond extends StatefulWidget {
  const GetRespond({Key key, this.passIdStories}) : super(key: key);
  final String passIdStories;

  @override
    _GetRespondState createState() => _GetRespondState();
}

class _GetRespondState extends State<GetRespond> {  
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('voting').orderBy('datetime', descending: false).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
          padding: const EdgeInsets.all(0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
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
                            GetUsername(passDocumentId: data['id_user'], textColor: const Color(0xFFF1c40f)),
                            Text("Voted ${data['voted']}", style: TextStyle(color: Colors.white))
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
                //
              },                   
            );
          }).toList(),
        );
      },
    );
  }
}