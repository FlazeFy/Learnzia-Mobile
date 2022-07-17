import 'package:flutter/material.dart';
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
        painter : CurvedPainter3(),
        child : SizedBox(
          height: fullHeight,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.08, left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("My Classroom", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  children:[
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => const MyDiscussionPage(),
                        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        //       final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                        //       final curvedAnimation = CurvedAnimation(
                        //         parent: animation,
                        //         curve: Curves.ease,
                        //       );

                        //       return SlideTransition(
                        //         position: tween.animate(curvedAnimation),
                        //         child: child,
                        //       );
                        //     }
                        //   ),
                        // );
                      },
                      child: Column(
                        children:[
                          Container(
                            height: 60,
                            width: 60,
                            transform: Matrix4.translationValues(0.0, -4.0, 0.0),
                            margin: const EdgeInsets.only(bottom:2),
                            child: ClipRRect(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(18),
                                child: Image.asset('assets/images/User.jpg', fit: BoxFit.cover),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                  ]
                )
              ),
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.08, left: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Contact", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    InkWell(
                      child: Card(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                          child: Row(
                            children: [ 
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(
                                    'assets/images/User.jpg', width: 50),
                                ),
                              ),
                              Expanded(                 
                                child: Column (
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(                     
                                          text: "richardkyle",
                                          style: const TextStyle(
                                            color: Color(0xFF212121),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          )
                                        ),                              
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(                     
                                        text: 'lorem ipsum',
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 128, 128, 128),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        )
                                      ),                              
                                    )
                                  ]
                                )
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    "Today at 16:40", 
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xFF808080)
                                    ),
                                  ),
                                )
                              ), 
                            ]
                          )    
                        )
                      ),
                      onTap: () { 
                        // 
                      },                   
                    )
                  ],
                )
              ),
            ]
          )
        ),
      )

    );
  }
}