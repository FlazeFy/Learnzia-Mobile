import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class GetStories extends StatefulWidget {
  @override
    _GetStoriesState createState() => _GetStoriesState();
}

class _GetStoriesState extends State<GetStories> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('stories').snapshots();

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

            getVoting(){
              if(data['type'] == 'voting'){
                return Container(
                  width: fullWidth*0.7,
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print(data['option1']);
                        },
                        child: Text(data['option1']),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          print(data['option2']);
                        },
                        child: Text(data['option2']),
                      ),
                    ],
                  )
                );
              } else {
                return const SizedBox();
              }
            }

            getBody(){
              if(data['text'] != 'null'){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['text'], style: const TextStyle(color: Colors.white, fontSize: 16)),
                    getVoting()
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