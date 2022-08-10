import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Forum/Story/GetComment.dart';
import 'package:learnzia/Firebase/Forum/Story/GetRespond.dart';
import 'package:learnzia/main.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class GetStories extends StatefulWidget {
  @override
    _GetStoriesState createState() => _GetStoriesState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _GetStoriesState extends State<GetStories> with TickerProviderStateMixin {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('stories').snapshots();
  CollectionReference comment= FirebaseFirestore.instance.collection('stories-comment');
  final _commentTextCtrl = TextEditingController();
  TabController _tabController;

  @override
  Widget CustomView(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  //Send comment.
  Future<void> sendComment(String id) async {
    return comment
      .add({
        'body': _commentTextCtrl.text, 
        'id_stories': id, 
        'id_user': passIdUser, 
        'datetime': DateTime.tryParse(DateTime.now().toIso8601String()), 
      })
      .then((value) => print("Comment has been sended"))
      .catchError((error) => print("Failed to send comment: $error"));
  }
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);              
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Stories(
          displayProgress: true,
          showStoryName: true,
          storyCircleTextStyle: const TextStyle(color: Color(0xFF313436), fontWeight: FontWeight.w500),
          storyItemList: snapshot.data.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            //Bottom sheet comment
            Widget _commentSheet(BuildContext context, ScrollController scrollController, double bottomSheetOffset) {
              return Material(
                child: Container(
                  padding: EdgeInsets.zero,
                  color: containerColor,
                  width: fullWidth,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child:ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, size: 35),
                          color: mainColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 15),
                              children: [
                                const TextSpan(
                                  text: "Comment", 
                                ),
                                const TextSpan(
                                  text: " (8)", 
                                ),
                              ]
                            )
                          ),
                        ),
                        Container(
                          height: fullHeight*0.63,
                          margin: const EdgeInsets.only(top:5),
                          child: GetStoriesComment(passIdStories: document.id),  
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                          height: 60,
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          color: const Color(0xFF414141),
                          child: Row(
                            children: <Widget>[                              
                              Expanded(
                                child: TextField(
                                  controller: _commentTextCtrl,
                                  decoration: const InputDecoration(
                                    hintText: "Type your comment...",
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
                                  sendComment(document.id);
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.send,color: Colors.white,size: 18,),
                                backgroundColor: Colors.green,
                                elevation: 0,
                              ),
                            ],
                            
                          ),
                        ),
                      ],
                    
                    ),
                  )
                ),
              );
            }

            //Bottom sheet setting
            Widget _settingSheet(BuildContext context, ScrollController scrollController, double bottomSheetOffset) {
              return Material(
                child: Container(
                  padding: EdgeInsets.zero,
                  color: containerColor,
                  width: fullWidth,
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child:ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, size: 35),
                          color: mainColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        
                        TabBar(
                          indicatorColor: const Color(0xFF7289DA),
                          labelColor: Colors.white,
                          controller: _tabController,
                          tabs: <Widget>[
                            const Tab(
                              text: "Respond",
                            ),
                            const Tab(
                              text: "Setting",
                            )
                          ],
                        ),
                        
                        Container(
                          height: fullHeight*0.63,
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              GetRespond(passIdStories: document.id),
                              Container(
                                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                                height: fullHeight,
                                child: Column(
                                  children: [
                                    
                                  ], 
                                ),
                              )
                            ]
                          )
                        )
                      ],
                    ),
                  )
                ),
              );
            }

            //Bottom sheet share


            //Stories image
            getimageBG(){
              if(data['url'] != 'null'){
                return BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data['url']),
                  ),
                );
              } else {
                return BoxDecoration(
                  color: containerColor
                );
              }
            }

            //Voting Stories
            getVoting(){
              if(data['type'] == 'voting'){
                return Container(
                  width: fullWidth*0.4,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: fullWidth*0.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            print(data['option1']);
                          },
                          child: Text(data['option1']),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: fullWidth*0.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            print(data['option2']);
                          },
                          child: Text(data['option2']),
                        ),
                      ),
                    ],
                  )
                );
              } else {
                return const SizedBox();
              }
            }

            getSetting(){
              if(data['id_user'] == passIdUser){
                return IconButton(
                  icon: const Icon(Icons.settings),
                  color: Colors.white,
                  iconSize: 30,
                  onPressed: () {
                    showFlexibleBottomSheet(
                      minHeight: 0,
                      initHeight: 0.8,
                      maxHeight: 0.8,
                      isDismissible: false,
                      bottomSheetColor: containerColor,
                      context: context,
                      builder: _settingSheet,
                      isExpand: true,
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            }

            //Comment & Share
            getComment(){
              if(data['comment'] == 'true'){
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: fullWidth,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.comment),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          showFlexibleBottomSheet(
                            minHeight: 0,
                            initHeight: 0.8,
                            maxHeight: 0.8,
                            isDismissible: false,
                            bottomSheetColor: containerColor,
                            context: context,
                            builder: _commentSheet,
                            isExpand: true,
                          );
                        },
                      ),
                      const SizedBox(width: 15),
                      IconButton(
                        icon: const Icon(Icons.share),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          
                        },
                      ),
                      const SizedBox(width: 15),
                      getSetting()
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    backgroundBlendMode: BlendMode.darken,
                  )
                );
              } else {
                return const SizedBox();
              }
            }

            //Stories body
            getBody(){
              if(data['text'] != 'null'){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(data['text'], style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    getVoting(),
                    getComment()
                  ]
                );
              } else {
                return const SizedBox();
              }
            }
            
            return StoryItem(
              name: "User",
              thumbnail: const AssetImage('assets/images/User.jpg'),
              stories: [
                Scaffold(
                  body: Container(
                    width: fullWidth,
                    height: fullHeight,
                    child: getBody(),
                    decoration: getimageBG()
                  ),
                ),
              ]
            );
          }).toList(),
        );
      },
    );
  }
}
