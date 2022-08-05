import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnzia/Firebase/Classroom/GetChannelname.dart';
import 'package:learnzia/Firebase/Classroom/GetChatOnChannel.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Widgets/sidebar.dart';
import 'package:learnzia/main.dart';
import 'dart:math';

class ClassroomPage extends StatefulWidget {
  const ClassroomPage({key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override

  _ClassroomPage createState() => _ClassroomPage();
}

class _ClassroomPage extends State<ClassroomPage> {
  final _messageTextCtrl = TextEditingController();

  CollectionReference message= FirebaseFirestore.instance.collection('classroom-message');
  XFile file;
  String seed = "null";

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

  //Get image picker
  Future<XFile> getImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
  
  //Create account.
  Future<void> sendChat(XFile imageFile, String seed) async {
    String type;
    String url;

    if (imageFile != null) {
      seed = getRandomString(20);
      
      // Create a Reference to the file
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('classroom')
          .child(seed);

      final metadata = SettableMetadata(
        //contentType: 'image', 
        customMetadata: {'picked-file-path': imageFile.path},
      );

      //return await ref.putData(await imageFile.readAsBytes(), metadata);
      await ref.putData(await imageFile.readAsBytes(), metadata);

      type = "image";
      url = await ref.getDownloadURL();
    } else {
      type = "text";
      url = "null";
    }
    
    return message
      .add({
        'body': _messageTextCtrl.text, 
        'id_channel': passIdChannel, 
        'id_classroom': widget.passIdClass, 
        'id_user': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
        'type': type,
        'url': url,
      })
      .then((value) => print("Chat has been sended"))
      .catchError((error) => print("Failed to send chat: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        iconTheme:  
          const IconThemeData(
          color: Color(0xFF313436),
          size: 35.0,
        ),
        actions: [
          GestureDetector(
            onTap: (){
              //
            },
            child: Container(
              width: fullWidth*0.75,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [ 
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/User.jpg', width: 40),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetClassname(passDocumentId: widget.passIdClass, textColor: const Color(0xFF010C10)),
                      GetChannelName(passDocumentId: passIdChannel, textColor: const Color(0xFF7289DA))
                    ]
                  )
                ]
              )    
            )
          ),
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.home),
              color: containerColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
            ),
          ),
        ],  
        backgroundColor: mainColor,
      ),
      drawer: NavDrawer(passIdClass: widget.passIdClass),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: GetChatOnChannel(classId: widget.passIdClass)
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: containerColor,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        //Bug : not close after back button is pressed
                        FullScreenMenu.show(
                          context,
                          backgroundColor: Colors.transparent,
                          items: [
                            FSMenuItem(
                              icon: Icon(Icons.mic, color: Colors.white),
                              text: Text('Audio', style: TextStyle(color: mainColor)),
                              gradient: blueGradient,
                            ),
                            FSMenuItem(
                              icon: Icon(Icons.file_copy, color: Colors.white),
                              text: Text('Document', style: TextStyle(color: mainColor)),
                              gradient: purpleGradient,
                            ),
                            FSMenuItem(
                              icon: Icon(Icons.image, color: Colors.white),
                              text: Text('Image', style: TextStyle(color: mainColor)),
                              gradient: redGradient,
                              onTap: () async {
                                file = await getImage();
                              },
                            ),
                          ],
                        );
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        controller: _messageTextCtrl,
                        decoration: const InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: InputBorder.none
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: () async{
                        sendChat(file, seed);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ClassroomPage(passIdClass: widget.passIdClass)),
                        );
                      },
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                      backgroundColor: Colors.green,
                      elevation: 0,
                    ),
                  ],
                  
                ),
              ),
            ),
          ], 
      
        ),
      )
    );
  }
}