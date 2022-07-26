import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Contact/CountContact.dart';
import 'package:learnzia/Firebase/Contact/GetContact.dart';
import 'package:learnzia/Widgets/customPainter.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight= MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomPaint(
        painter : CurvedPainter(),
        child : SizedBox(
          height: fullHeight,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.06, left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Contact", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const TextField(
                  //onChanged: (value) => ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Subject',
                    fillColor: Color(0xFF5A5d5e),
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(bottom: fullHeight*0.05, left: 10),
                child: CountContact(),
              ),
              Expanded(
                child: GetContact(),
              ),
            ]
          )
        ),
      )

    );
  }
}