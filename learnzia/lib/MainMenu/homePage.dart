import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/GetQuestion.dart';
import 'package:learnzia/Widgets/customPainter.dart';
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
        child : Container(
          padding: const EdgeInsets.all(10.0),
          height: fullHeight,
          width: fullWidth,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: fullHeight*0.08),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Friend's Post", style: TextStyle(color: Color(0xFF313436), fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Container(
                margin: EdgeInsets.only(bottom: fullHeight*0.04),
                child: Stories(
                  displayProgress: true,
                  showStoryName: true,
                  storyCircleTextStyle: const TextStyle(color: Color(0xFF313436), fontWeight: FontWeight.w500),
                  storyItemList: [
                    StoryItem(
                      name: "New Post",
                      thumbnail: const NetworkImage(
                        "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
                      ),
                      stories: [
                        // First story
                        Scaffold(
                          body: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://wallpaperaccess.com/full/16568.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                    ),
                    // Second story group
                    StoryItem(
                      name: "2nd",
                      thumbnail: const NetworkImage(
                        "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
                      ),
                      stories: [
                        const Scaffold(
                          body: Center(
                            child: Text(
                              "That's it, Folks !",
                              style: TextStyle(
                                color: Color(0xff777777),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                        // Second story in first group
                        const Scaffold(
                          body: Center(
                            child: Text(
                              "Second story in first group !",
                              style: TextStyle(
                                color: Color(0xff777777),
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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