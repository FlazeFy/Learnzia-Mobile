import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/GetMyClassroomList.dart';
import 'package:learnzia/Widgets/customPainter.dart';
import 'package:learnzia/main.dart';

class ClassroomListPage extends StatefulWidget {
  const ClassroomListPage({Key key}) : super(key: key);

  @override
  _ClassroomListPageState createState() => _ClassroomListPageState();
}

class _ClassroomListPageState extends State<ClassroomListPage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight= MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme:  
          const IconThemeData(
          color: Color(0xFF313436),
          size: 35.0,
        ),
        backgroundColor: mainColor,
      ),
      body: CustomPaint(
        painter : CurvedPainter4(),
        child : SizedBox(
          height: fullHeight,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("My Classroom", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const TextField(
                  //onChanged: (value) => ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search by class name',
                    fillColor: Color(0xFF5A5d5e),
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: fullHeight*0.1),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Show .. Contact", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 14)),
                )
              ),
              Expanded(
                child: GetMyClassroomList(),
              ),
            ]
          )
        ),
      )

    );
  }
}