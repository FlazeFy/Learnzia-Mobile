import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Widgets/dropdown.dart';
import 'package:learnzia/SecondaryMenu/myDiscussionPage.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
      body: ListView(
        padding: const EdgeInsets.only(top: 0),
        children:[
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Create Post", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 18)),
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
      
    );
  }
}