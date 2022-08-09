import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/GetQuestion.dart';
import 'package:learnzia/Firebase/Forum/Story/GetStories.dart';
import 'package:learnzia/SecondaryMenu/myDiscussionPage.dart';
import 'package:learnzia/Widgets/customPainter.dart';
import 'package:learnzia/main.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomPaint(
        painter : CurvedPainter(),
        child : SizedBox(
          height: fullHeight,
          width: fullWidth,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.06, left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Friend's Post", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
                margin: EdgeInsets.only(bottom: fullHeight*0.04),
                padding: const EdgeInsets.only(left:10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => const MyDiscussionPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.ease,
                              );

                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            }
                          ),
                        );
                      },
                      child: Column(
                        children:[
                          Container(
                            height: 60,
                            width: 60,
                            transform: Matrix4.translationValues(0.0, -4.0, 0.0),
                            margin: const EdgeInsets.only(bottom:2),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(18),
                                child: Image.asset('assets/images/User.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color(0xFF212121),
                                width: 3,
                              ),
                              color: const Color(0xFF313436),
                            )
                          ),
                          const Text("New Post", style: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.w500))
                        ]
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 115,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children:[
                            GetStories()
                          ]
                        )
                      )
                    )
                  ],
                )
              ),

              Flexible(
                child:
                  GetQuestion(),
              )
            ]
          )
        )
      ),

    );
  }
}