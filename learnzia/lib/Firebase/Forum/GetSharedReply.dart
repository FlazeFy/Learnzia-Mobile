import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/Firebase/Forum/CheckUpButton.dart';
import 'package:learnzia/Firebase/Forum/GetContactToShare.dart';
import 'package:learnzia/main.dart';

class GetSharedReply extends StatelessWidget {
  GetSharedReply({Key key, this.passIdReply, this.topLeft, this.topRight}) : super(key: key);
  final String passIdReply;
  var topLeft;
  var topRight;

  final Stream<QuerySnapshot> _reply = FirebaseFirestore.instance.collection('reply').snapshots();

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return StreamBuilder<QuerySnapshot>(
      stream: _reply,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center( 
            child: CircularProgressIndicator()
          );
        }

        return Column(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(document.id == passIdReply){
              Widget getImage(){
                if(data['image'] == "null"){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Text("${data['body']}", style: const TextStyle(color: Colors.white))
                  );
                } else {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                    child: Column(
                      children:[
                        ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/images/${data['image']}'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text("${data['body']}", style: const TextStyle(color: Colors.white))
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
                  margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(formattedDate, style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic)
                  )
                );
              }
              return Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: fullWidth*0.7,
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
                    getImage(),
                    Row(
                      children: [
                        CheckUpButton(passDocumentId: document.id),
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
                                        child: GetContactToShare(passIdQuestion: document.id, passTypeSend: "reply")
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
                  borderRadius: BorderRadius.only(topRight: topRight, bottomRight: const Radius.circular(10), bottomLeft: const Radius.circular(10), topLeft: topLeft),
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