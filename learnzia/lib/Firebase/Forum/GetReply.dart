import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/GetUsername.dart';
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
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('reply').where('id_discussion', isEqualTo: widget.passIdDisc).snapshots();

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

            Widget replyBox(){
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
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: fullWidth*0.3,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_upward),
                            label: const Text("102", style: TextStyle(fontSize: 16)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 226, 184, 14)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                              )
                            ),
                            onPressed: () {
                              
                            },
                          ),
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
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
                )
              );
            }

            if(i == 0){
              i++;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text("Showing ${snapshot.data.size.toString()} replies", style: TextStyle(color: mainColor, fontSize: 13, fontStyle: FontStyle.italic)),
                  ),
                  replyBox()
                ],
              );
            }
           
            return replyBox();
          }).toList(),
        );
      },
    );
  }
}