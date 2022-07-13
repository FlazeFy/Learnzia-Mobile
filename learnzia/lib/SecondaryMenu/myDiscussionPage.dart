import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Widgets/customPainter.dart';
import 'package:learnzia/Widgets/dropdown.dart';

String categoryCtrl = "";

class myDiscussionPage extends StatefulWidget {
  const myDiscussionPage({Key key}) : super(key: key);

  @override
  _myDiscussionPageState createState() => _myDiscussionPageState();
}

class _myDiscussionPageState extends State<myDiscussionPage> {
  CollectionReference disc = FirebaseFirestore.instance.collection('discussion');

  //Create account.
  Future<void> createDiscussion() {
    return disc
      .add({
        'subject': subjectCtrl.text, 
        'question': questionCtrl.text, 
        'category': categoryCtrl, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'image': 'null', // for now. 
      })
      .then((value) => print("Akun berhasil didaftar"))
      .catchError((error) => print("Failed to add user: $error"));
  }
  
  
  var subjectCtrl = TextEditingController();
  var questionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomPaint(
        painter : CurvedPainter2(),
        child : Container(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Column(
            children:[
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.1, bottom: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Preview Post", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
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
                          width: fullWidth*0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("flazefy", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text("-", style: TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ]
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: const Text("-", style: TextStyle(color: Colors.white))
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: fullWidth*0.3,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_upward),
                            label: const Text("0", style: TextStyle(fontSize: 16)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 226, 184, 14)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                              )
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: fullWidth*0.2,
                          child: TextButton.icon(
                            onPressed: () {
                                // Respond to button press
                            },
                            icon: const Icon(Icons.comment, size: 20, color: Colors.white),
                            label: const Text("0", style: TextStyle(color: Colors.white)),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: fullWidth*0.2),
                          child: IconButton(
                            icon: const Icon(Icons.send, size: 20),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ), 
                      ]
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A5D5E).withOpacity(0.8),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
                )
              ), //End of preview container.

              Container(
                margin: EdgeInsets.only(top: fullHeight*0.1),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Preview Post", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 18)),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children:const [
                          Text("Category :", style: TextStyle(color: Colors.white, fontSize: 16)),
                          Spacer(),
                          DropDownCategory()
                        ]
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: subjectCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Subject',
                          fillColor: Color(0xFF5A5d5e),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: questionCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Question',
                          fillColor: Color(0xFF5A5d5e),
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: fullWidth*0.3,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Post", style: TextStyle(fontSize: 16)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 226, 184, 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )
                    )
                  ),
                  onPressed: () async{
                    createDiscussion();
                  },
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}