import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Profile/GetMyInvitation.dart';
import 'package:learnzia/SecondaryMenu/TabController/myPost.dart';
import 'package:learnzia/main.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          labelColor: containerColor,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: "My Question",
            ),
            Tab(
              text: "My Stories",
            ),
            Tab(
              text: "Bookmarks",
            )
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyPost(),
          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: fullHeight,
            child: Column(
              children: [
                
              ], 
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: fullHeight,
            child: Column(
              children: [
                
              ], 
            ),
          ),
        ]
      )
          
    );
    
  }
}