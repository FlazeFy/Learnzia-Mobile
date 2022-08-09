

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/Firebase/Forum/CheckUpButton.dart';
import 'package:learnzia/Firebase/Forum/CountReply.dart';
import 'package:learnzia/Firebase/Forum/GetContactToShare.dart';
import 'package:learnzia/SecondaryMenu/replyPage.dart';
import 'package:learnzia/main.dart';

class GetQuestion extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('discussion').orderBy('datetime', descending: true).snapshots();

  GetQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

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
          padding: const EdgeInsets.only(top: 0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            addBookmark() async {
              CollectionReference bookmark= FirebaseFirestore.instance.collection('bookmark');

              return bookmark
              .add({
                'id_user': passIdUser, 
                'id_context': document.id, 
                'type': 'question', 
                'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
                'description': 'null',
              })
              .then((value) => print("Question has been added to bookmark"))
              .catchError((error) => print("Failed add to bookmark: $error"));
            }

            Widget getImage(){
              if(data['image'] == "null"){
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text("${data['subject']} - ${data['question']}", style: const TextStyle(color: Colors.white))
                );
              } else {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    children:[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(data['image']),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 5),
                        child: Text("${data['subject']} - ${data['question']}", style: const TextStyle(color: Colors.white))
                      )
                    ]
                  )
                );
              }
            }
            Widget getDate(){
              var dt = DateTime.fromMicrosecondsSinceEpoch(data['datetime'].microsecondsSinceEpoch).toString();
              var date = DateTime.parse(dt);
              var formattedDate = "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)
                )
              );
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(data['category'], style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        color: Colors.white,
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: containerColor,
                              content: Container(
                                height: 145,
                                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:[
                                    Container(
                                      transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                                      child: IconButton(
                                        icon: Icon(Icons.close, color: mainColor),
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: OutlinedButton.icon(
                                        onPressed: () async {
                                          addBookmark();
                                          return showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: containerColor,
                                                title: Text('Success', style: TextStyle(fontWeight: FontWeight.bold, color: mainColor)),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      ClipRRect(
                                                        child: Image.asset(
                                                          'assets/icons/success.png', width: 20),
                                                      ),
                                                      const Text('Question has been added to bookmark', style: TextStyle(color: Colors.white)),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Continue', style: TextStyle(color: mainColor)),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            }
                                          );
                                        },
                                        icon: Icon(Icons.bookmark, size: 18, color: containerColor),
                                        label: Text("Add To Bookmark", style: TextStyle(color: containerColor)),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: OutlinedButton.icon(
                                        onPressed: () async{
                                          
                                        },
                                        icon: Icon(Icons.delete, size: 18, color: containerColor),
                                        label: Text("Report", style: TextStyle(color: containerColor)),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                                        ),
                                      )
                                    )
                                  ]
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ]
                  ),
                  getImage(),
                  getDate(),
                  Row(
                    children: [
                      CheckUpButton(passDocumentId: document.id),
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: fullWidth*0.2,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ReplyPage(passIdDisc: document.id, id_user: data['id_user'])),
                            );
                          },
                          icon: const Icon(Icons.comment, size: 20, color: Colors.white),
                          label: CountReply(passDocumentId: document.id)
                        )
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.send, size: 20),
                        color: Colors.white,
                        onPressed: () async {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: SizedBox(
                                height: fullHeight*0.7,
                                width: fullWidth*0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    Container(
                                      transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                                      child: IconButton(
                                        icon: Icon(Icons.close, color: mainColor),
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: fullHeight*0.6,
                                      width: fullWidth*0.8,
                                      child: GetContactToShare(passIdQuestion: document.id, passTypeSend: "question")
                                    ),
                                  ]
                                ),
                              ),
                            ),
                          );
                        },
                      ), 
                    ]
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
              )
            );

          }).toList(),
        );
      },
    );
  }
}

class GetMyQuestion extends StatelessWidget {

  final Stream<QuerySnapshot> _diskusi = FirebaseFirestore.instance.collection('discussion').orderBy('datetime', descending: true).snapshots();
  
  GetMyQuestion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

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
          padding: const EdgeInsets.all(3.0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_user'] == passIdUser){
              Widget getImage(){
                if(data['image'] == "null"){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Text("${data['subject']} - ${data['question']}", style: const TextStyle(color: Colors.white))
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Column(
                      children:[
                        ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(data['image'])),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 5),
                          child: Text("${data['subject']} - ${data['question']}", style: const TextStyle(color: Colors.white))
                        )
                      ]
                    )
                  );
                }
              }
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
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          width: fullWidth*0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetUsername(passDocumentId: data['id_user']),
                              Text(data['category'], style: const TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {
                            
                          },
                        ),
                      ]
                    ),
                    getImage(),
                    getDate(),
                    Row(
                      children: [
                        CheckUpButton(passDocumentId: document.id),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: fullWidth*0.2,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ReplyPage(passIdDisc: document.id)),
                              );
                            },
                            icon: const Icon(Icons.comment, size: 20, color: Colors.white),
                            label: CountReply(passDocumentId: document.id)
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: fullWidth*0.2),
                          child: IconButton(
                            icon: const Icon(Icons.send, size: 20),
                            color: Colors.white,
                            onPressed: () async {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  contentPadding: const EdgeInsets.all(0),
                                  content: SizedBox(
                                    height: fullHeight*0.7,
                                    width: fullWidth*0.8,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        Container(
                                          transform: Matrix4.translationValues(20.0, 0.0, 0.0),
                                          child: IconButton(
                                            icon: Icon(Icons.close, color: mainColor),
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: fullHeight*0.6,
                                          width: fullWidth*0.8,
                                          child: GetContactToShare(passIdQuestion: document.id, passTypeSend: "question")
                                        ),
                                      ]
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ), 
                      ]
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
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