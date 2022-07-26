import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/GetMyInvitation.dart';
import 'package:learnzia/main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

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
        bottom: TabBar(
          indicatorColor: const Color(0xFF7289DA),
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.history, color: containerColor),
            ),
            Tab(
              icon: Icon(Icons.mail_rounded, color: containerColor),
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10),
            
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: fullHeight,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Invitation", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Flexible(
                  child: GetMyInvitation()
                )
              ], 
            ),
          ),

        ]
      )
          
    );
    
  }
}