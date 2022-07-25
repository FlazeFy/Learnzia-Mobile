import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetAllChannelManage.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Widgets/sidebar.dart';
import 'package:learnzia/main.dart';

class ChannelPage extends StatefulWidget {
  const ChannelPage({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  CollectionReference channel= FirebaseFirestore.instance.collection('channel');
  final channelnameCtrl = TextEditingController();
  final channeldescCtrl = TextEditingController();

  Future<void> createChannel() {
    return channel
      .add({
        'channel_name': channelnameCtrl.text, 
        'channel_description': channeldescCtrl.text,
        'id_user': passIdUser, 
        'id_classroom': widget.passIdClass, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
      })
      .then((value) => print("Successfully create channel"))
      .catchError((error) => print("Failed to add user: $error"));
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
                      const Text("Manage Channel", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF7289DA), fontSize: 15))
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

      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 10),
        child: ListView(
          padding: const EdgeInsets.only(top: 0, left: 10),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text("Create New Channel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Channel Name", style: TextStyle(color: mainColor)),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              margin: const EdgeInsets.only(top: 5, bottom: 5, right: 40),
              child: TextField(
                controller: channelnameCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Color(0xFF5A5d5e),
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Channel Description", style: TextStyle(color: mainColor)),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              margin: const EdgeInsets.only(top: 5, bottom: 5, right: 40),
              child: TextField(
                controller: channeldescCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Color(0xFF5A5d5e),
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if((channelnameCtrl.text.isNotEmpty)&&(channeldescCtrl.text.isNotEmpty)){
                        createChannel();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NavBar()),
                        );
                      } else {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.asset(
                                        'assets/icons/Wrong.png', width: 20),
                                    ),
                                    const Text('Field cannot be empty'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                    ),
                    icon: const Icon(Icons.save, size: 18),
                    label: const Text("Save Changes"),
                  )
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text("All Channel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Flexible(
              child: Container(
              height: 400,
              margin: const EdgeInsets.only(top: 5),
                child: GetAllChannelManage(passDocumentId: widget.passIdClass, passIdClass: widget.passIdClass)
              ), 
            ), 
          ], 
        ),
      )
          
        
    );
  }
}