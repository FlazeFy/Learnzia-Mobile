import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/main.dart';

class GetStoriesComment extends StatefulWidget {
  const GetStoriesComment({Key key, this.passIdStories}) : super(key: key);
  final String passIdStories;

  @override
    _GetStoriesCommentState createState() => _GetStoriesCommentState();
}

class _GetStoriesCommentState extends State<GetStoriesComment> {  
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('stories-comment').orderBy('datetime', descending: false).snapshots();

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

        int i = 0;
        return ListView(
          padding: const EdgeInsets.all(0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_stories'] ==  widget.passIdStories){
              Widget getDate(){
                var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
                var date = DateTime.parse(dt);
                var formattedDate = "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)
                  )
                );
              }

              Widget commentBox(){
                return Container(
                  margin: const EdgeInsets.only(bottom: 15, right: 10),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children:[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/User.jpg', width: 40),
                              ),
                          ),
                          SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetUsername(passDocumentId: data['id_user'], textColor: const Color(0xFFF1c40f)),
                                getDate(),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            color: Colors.white,
                            onPressed: () async {

                            },
                          ),
                        ]
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text("${data['body']}", style: const TextStyle(color: Colors.white))
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: containerColor,
                    border: Border.all(
                      color: mainColor,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  )
                );
              }

              //Instrinsic defect, when the text is to long!!

              //First item in looping.
              if(i == 0){
                i++;
                return SizedBox(
                  width: fullWidth,
                  child: IntrinsicHeight(
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: fullWidth*0.1),
                          width: 3,
                          color: mainColor,
                        ),
                        Container(
                          width: 25,
                          margin: EdgeInsets.symmetric(horizontal: fullWidth*0.075),
                          transform: Matrix4.translationValues(0.0, -15.0, 0.0),
                          decoration: BoxDecoration(
                            color: containerColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: mainColor,
                              width: 3,
                            )
                          ),
                        ),
                        Container(
                          width: fullWidth*0.8,
                          transform: Matrix4.translationValues(70.0, 0.0, 0.0),
                          child: commentBox()
                        ),
                      ],
                    ),
                  )
                );
              }

              //Second item etc.
              i++;
              return SizedBox(
                width: fullWidth,
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: fullWidth*0.1),
                        width: 3,
                        color: mainColor,
                      ),
                      Container(
                        width: 25,
                        margin: EdgeInsets.symmetric(horizontal: fullWidth*0.075),
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        decoration: BoxDecoration(
                          color: containerColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: mainColor,
                            width: 3,
                          )
                        ),
                      ),
                      Container(
                        width: fullWidth*0.8,
                        transform: Matrix4.translationValues(70.0, 0.0, 0.0),
                        child: commentBox()
                      ),
                    ],
                  ),
                )
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