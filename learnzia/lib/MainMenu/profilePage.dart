import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/ClassroomListPage.dart';
import 'package:learnzia/Firebase/Profile/CountClassroom.dart';
import 'package:learnzia/Firebase/Profile/CountFriends.dart';
import 'package:learnzia/Firebase/Profile/FriendsListPage.dart';
import 'package:learnzia/Firebase/Profile/GetMiniProfile.dart';
import 'package:learnzia/MainMenu/loginPage.dart';
import 'package:learnzia/SecondaryMenu/TabController/createPost.dart';
import 'package:learnzia/SecondaryMenu/myDiscussionPage.dart';
import 'package:learnzia/SecondaryMenu/notificationPage.dart';
import 'package:learnzia/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  CollectionReference users= FirebaseFirestore.instance.collection('user');

  Future<void> loginStatus(String id) {
    return users
      .doc(id)
      .update({
        'status': 'offline', 
      })
      .then((value) => print("Login success"))
      .catchError((error) => print("Failed to update status: $error"));
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: fullHeight*0.07), 
        child: Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              GetMiniProfile(passIdUser),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  SizedBox(
                    width: fullWidth*0.44,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: fullWidth*0.44,
                          margin: const EdgeInsets.only(bottom: 5, left:10),
                          child: TextButton.icon(
                            onPressed: () async {
                              loginStatus(passIdUser); 
                              
                              passIdUser = "";
                              passUsername = "";
                              subjectPrev = "-";
                              questionPrev = "-";
                              categoryCtrl = "-";
                         
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            icon: const Icon(Icons.logout, size: 22, color: Colors.white,),
                            label: const Text("Sign Out", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFdf4759),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const NotificationPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: fullWidth*0.44,
                            margin: const EdgeInsets.only(bottom: 5, left:10),
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.asset(
                                  'assets/icons/Invitation.png', width: fullWidth*0.15),
                                ),
                                Container(
                                  margin:const EdgeInsets.only(bottom: 15), 
                                  child: const Text("Notification", style: TextStyle(color: Colors.white, fontSize: 16))
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: containerColor,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: fullWidth*0.44,
                          margin: const EdgeInsets.only(bottom: 5, left:10),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                'assets/icons/setting.png', width: fullWidth*0.17),
                              ),
                              Container(
                                margin:const EdgeInsets.only(bottom: 15), 
                                child: const Text("Setting", style: TextStyle(color: Colors.white, fontSize: 16))
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: fullWidth*0.44,
                          margin: const EdgeInsets.only(bottom: 5, left:10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                'assets/icons/about.png', width: fullWidth*0.17),
                              ),
                              Container(
                                margin:const EdgeInsets.only(bottom: 15), 
                                child: const Text("About Us", style: TextStyle(color: Colors.white, fontSize: 16))
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          )
                        ),
                        
                      ]
                    ), 
                  ),
                  const Spacer(),
                  SizedBox(
                    width: fullWidth*0.53,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FriendsListPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 5, right:10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset(
                                  'assets/icons/Friends.png', width: fullWidth*0.17),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: fullWidth*0.2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:const EdgeInsets.only(bottom: 15), 
                                        child: const Text("Friends", style: TextStyle(color: Color(0xFF212121), fontSize: 14, fontWeight: FontWeight.w500))
                                      ),
                                      CountFriends(passDocumentId: passIdUser)
                                    ],
                                  )
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFF1C40F).withOpacity(0.9),
                                  const Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
                                ],
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            )
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ClassroomListPage()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 5, right:10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset(
                                  'assets/icons/Classroom.png', width: fullWidth*0.17),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: fullWidth*0.2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin:const EdgeInsets.only(bottom: 15), 
                                        child: const Text("Classroom", style: TextStyle(color: Color(0xFF212121), fontSize: 14, fontWeight: FontWeight.w500))
                                      ),
                                      CountClassroom(passDocumentId: passIdUser)
                                    ],
                                  )
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFF1C40F).withOpacity(0.9),
                                  const Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
                                ],
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 5, right:10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                'assets/icons/Statistics.png', width: fullWidth*0.17),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: fullWidth*0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(bottom: 15), 
                                      child: const Text("Statistics", style: TextStyle(color: Color(0xFF212121), fontSize: 14, fontWeight: FontWeight.w500))
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: fullWidth*0.45,
                                      child: const Text("3", maxLines: 1, overflow: TextOverflow.ellipsis, 
                                        style: TextStyle(color: Color(0xFF212121), fontSize: 22, fontWeight: FontWeight.bold)
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF7289DA).withOpacity(0.9),
                                const Color.fromARGB(255, 75, 98, 180).withOpacity(0.9),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 5, right:10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                'assets/icons/privacy.png', width: fullWidth*0.17),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: fullWidth*0.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(bottom: 15), 
                                      child: const Text("Privacy & Condition", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          )
                        )
                      ]
                    )
                  )
                ]
              )
            ],
          )
            
        )
      ),

    );
  }
}