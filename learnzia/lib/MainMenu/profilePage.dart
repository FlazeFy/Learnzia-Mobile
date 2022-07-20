import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/GetMiniProfile.dart';
import 'package:learnzia/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: fullHeight*0.1), 
        child: Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 0),
            children: [
              GetMiniProfile("0Xnz2jIQf3BLk7MZ9jiA"),
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
                            onPressed: () {
                                // Respond to button press
                            },
                            icon: const Icon(Icons.logout, size: 22, color: Colors.white,),
                            label: const Text("Sign Out", style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                          decoration: const BoxDecoration(
                            color: Color(0xFFdf4759),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
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
                                'assets/icons/Classroom.png', width: fullWidth*0.17),
                              ),
                              Container(
                                margin:const EdgeInsets.only(bottom: 15), 
                                child: const Text("Notification", style: TextStyle(color: Colors.white, fontSize: 16))
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: containerColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        Container(
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
                                      child: const Text("Friends", style: TextStyle(color: Color(0xFF212121), fontSize: 16))
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: fullWidth*0.45,
                                      child: const Text("20", maxLines: 1, overflow: TextOverflow.ellipsis, 
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
                                const Color(0xFFF1C40F).withOpacity(0.9),
                                const Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
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
                                      child: const Text("Classroom", style: TextStyle(color: Color(0xFF212121), fontSize: 16))
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
                                const Color(0xFFF1C40F).withOpacity(0.9),
                                const Color.fromARGB(255, 244, 140, 13).withOpacity(0.9),
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
                                      child: const Text("Statistics", style: TextStyle(color: Color(0xFF212121), fontSize: 16))
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