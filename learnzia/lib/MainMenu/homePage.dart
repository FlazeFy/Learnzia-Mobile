import 'package:flutter/material.dart';
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
                  child: Text("Friend's Post", style: TextStyle(color: Colors.white, fontWeight:FontWeight.bold, fontSize: 18)),
                )
              ),
              Stories(
                displayProgress: true,
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
                  ]),
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
                    ],
                  ),
                ],
              ),

              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: fullHeight*0.05),
                  child:ListView(
                    padding: const EdgeInsets.only(top:0),
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
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
                                Column(
                                  children: const [
                                    Text("flazefy", style: TextStyle(color: Colors.white, fontSize: 16)),
                                    Text("History", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: fullWidth*0.5),
                                  child: IconButton(
                                    icon: const Icon(Icons.more_vert),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                              ]
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/discussion_teresevy20220128101512.jpg'),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.arrow_upward),
                                    label: const Text("102", style: TextStyle(fontSize: 16)),
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
                                  child: TextButton.icon(
                                    onPressed: () {
                                        // Respond to button press
                                    },
                                    icon: const Icon(Icons.comment, size: 20, color: Colors.white),
                                    label: const Text("8", style: TextStyle(color: Colors.white)),
                                  )
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: IconButton(
                                    icon: const Icon(Icons.send, size: 20),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: fullWidth*0.2),
                                  child: IconButton(
                                    icon: const Icon(Icons.bookmark_outline, size: 20),
                                    color: Colors.white,
                                    onPressed: () {},
                                  ),
                                ), 
                              ]
                            ),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("flazefy", style: TextStyle(color: Colors.white, fontSize: 16)),
                                  const Text("History", style: TextStyle(color: Colors.grey, fontSize: 14)),
                                ]
                              )
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5A5D5E).withOpacity(0.8),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        )
                      ),
                    ],
                  )
                )
              )

            ]
          )
        )
      ),

    );
  }
}