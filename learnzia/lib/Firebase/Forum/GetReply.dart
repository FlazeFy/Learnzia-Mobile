import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
import 'package:learnzia/Firebase/Forum/CheckUpButton.dart';
import 'package:learnzia/Firebase/Forum/CountReply.dart';
import 'package:learnzia/Firebase/Forum/GetContactToShare.dart';
import 'package:learnzia/main.dart';

class GetReply extends StatefulWidget {
  const GetReply({Key key, this.passIdDisc}) : super(key: key);
  final String passIdDisc;

  @override
    _GetReplyState createState() => _GetReplyState();
}

class _GetReplyState extends State<GetReply> {  
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('reply').orderBy('datetime', descending: false).snapshots();

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
          padding: const EdgeInsets.all(0),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if(data['id_discussion'] ==  widget.passIdDisc){
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

              getVerified(){
                if(data['status'] == "verified"){
                  return BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: mainColor,
                      width: 3,
                    )
                  );              
                } else {
                  return BoxDecoration(
                    color: containerColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: mainColor,
                      width: 3,
                    )
                  );  
                }
              }

              getVerified2(){
                if(data['status'] == "verified"){
                  return Border.all(
                    color: Colors.green,
                    width: 2,
                  );              
                } else {
                  return null;  
                }
              }

              Widget replyBox(){
                return Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
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
                    border: getVerified2(),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
                  )
                );
              }

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
                          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                          decoration: getVerified(),
                        ),
                        Container(
                          width: fullWidth*0.8,
                          transform: Matrix4.translationValues(70.0, 0.0, 0.0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child:  Row(
                                  children: [
                                    Text("Showing ", style: TextStyle(color: mainColor, fontSize: 13, fontStyle: FontStyle.italic)),
                                    CountReply2(passDocumentId: widget.passIdDisc),
                                    Text(" replies", style: TextStyle(color: mainColor, fontSize: 13, fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                              replyBox()
                            ],
                          )
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
                        transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                        decoration: getVerified(),
                      ),
                      Container(
                        width: fullWidth*0.8,
                        transform: Matrix4.translationValues(70.0, 5.0, 0.0),
                        child: Column(
                          children: [
                            replyBox()
                          ],
                        )
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