import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class GetMyStories extends StatefulWidget {
  @override
  GetMyStories({Key key}) : super(key: key);

  @override
  _GetMyStoriesState createState() => _GetMyStoriesState();
}

class _GetMyStoriesState extends State<GetMyStories> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('stories').snapshots();

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

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
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            Widget getStories(){
              return Container(
                height: fullWidth*0.32,
                width: fullWidth*0.32,
                margin: EdgeInsets.only(left: fullWidth*0.01, top: fullWidth*0.01),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: NetworkImage(data['url']),
                    colorFilter: 
                      ColorFilter.mode(Colors.black.withOpacity(0.5), 
                      BlendMode.darken
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }
            
            if(data['id_user'] == passIdUser){
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getStories()
                ],
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