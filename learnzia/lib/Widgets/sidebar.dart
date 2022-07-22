import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/GetChannel.dart';
import 'package:learnzia/SecondaryMenu/channelPage.dart';
import 'package:learnzia/main.dart';

class NavDrawer extends StatelessWidget{
  var passIdClass;

  NavDrawer({Key key, this.passIdClass}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: containerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              //
            },
            child: Container(
              margin: EdgeInsets.only(top: fullHeight*0.1, left: 15),
              width: fullWidth*0.65,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Classroom Setting", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Edit, delete classroom, promote, demote, invite, and kick member", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                ]
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF7289DA),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChannelPage(passIdClass: passIdClass)),
              );
            },
            child: Container(
              width: fullWidth*0.65,
              margin: const EdgeInsets.only(top: 15, left: 15),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Manage Channel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const Text("Create, edit, and delete channel", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                ]
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15),
            child: const Text("All Channel", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: GetChannel(passDocumentId: passIdClass, passIdClass: passIdClass)
            ),
          ),
        ],
      )
    );
  }
}