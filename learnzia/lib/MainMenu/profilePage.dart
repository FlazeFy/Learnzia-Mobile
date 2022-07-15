import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/GetMiniProfile.dart';

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
        child: Column(
          children: const [
            GetMiniProfile("0Xnz2jIQf3BLk7MZ9jiA")
          ]
        )
      ),

    );
  }
}