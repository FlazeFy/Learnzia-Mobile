import 'package:flutter/material.dart';
import 'package:learnzia/SecondaryMenu/TabController/createPost.dart';
import 'package:learnzia/SecondaryMenu/TabController/myPost.dart';
import 'package:learnzia/Widgets/customPainter.dart';
import 'package:learnzia/main.dart';

String subjectPrev = "-";
String questionPrev = "-";

class MyDiscussionPage extends StatefulWidget {
  const MyDiscussionPage({Key key}) : super(key: key);

  @override
  _MyDiscussionPageState createState() => _MyDiscussionPageState();
}

class _MyDiscussionPageState extends State<MyDiscussionPage> {
  
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
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
        painter : CurvedPainter2(),
        child : Container(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Column(
            children:[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                          width: fullWidth*0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(passUsername, style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text(categoryCtrl, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ]
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Text("${subjectPrev} ~ ${questionPrev}", style: const TextStyle(color: Colors.white))
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
                  color: containerColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(55)),
                )
              ), //End of preview container.
              SizedBox(height: fullHeight*0.08),
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150.0),
                        child: const Material(
                          color: Colors.transparent,
                          child: TabBar(
                            indicatorColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Create Post"),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("My Post"),
                                ),
                              ),
                            ],
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              color: Color.fromARGB(255, 166, 204, 242),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          height: fullHeight,
                          child: const TabBarView(
                            children: [
                              CreatePost(),
                              MyPost(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),  
            ]
          )
        )
      ),
    );
  }
}