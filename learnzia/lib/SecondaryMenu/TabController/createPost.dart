import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnzia/SecondaryMenu/myDiscussionPage.dart';
import 'package:learnzia/Widgets/dropdown.dart';
import 'package:learnzia/main.dart';
import 'dart:math';


String categoryCtrl = "";

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  CollectionReference disc = FirebaseFirestore.instance.collection('discussion');
  XFile file;

  //Create post.
  Future<void> createDiscussion() {
    String seed = "null";
    if(file != null){
      seed = getRandomString(20);
      uploadImage(file, seed);
    }
    return disc
      .add({
        'subject': subjectCtrl.text, 
        'question': questionCtrl.text, 
        'category': categoryCtrl, 
        'id_user': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'image': seed,
      })
      .then((value) => print("Discussion has been posted"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  //Create random string.
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => 
    String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(
        _rnd.nextInt(_chars.length)
      )
    )
  );

  //Upload image.
  Future<void> uploadImage(XFile imageFile, String seed) async {
    if (imageFile== null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('discussion')
        .child(seed);

    final metadata = SettableMetadata(
      //contentType: 'image', 
      customMetadata: {'picked-file-path': imageFile.path},
    );

    return await ref.putData(await imageFile.readAsBytes(), metadata);
    
  }
  
  
  var subjectCtrl = TextEditingController();
  var questionCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
        children:[
          Column(
            children: [
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
                  onChanged: (value) => subjectPrev = value.toString(),
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
                  onChanged: (value) => questionPrev = value.toString(),
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
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  file = await getImage();
                  //imagePath = await 
                  // uploadImage(file);

                  // setState(() {});
                },
                icon: Icon(Icons.upload, size: 18, color: const Color(0xFF7289DA)),
                label: Text("Add Image", style: TextStyle(color: const Color(0xFF7289DA))),
              ),
              Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
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
                    setState(() {});
                  },
                ),
              ),
            ],
          )
          
        ]
      )
      
    );
  }
}

Future<XFile> getImage() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}