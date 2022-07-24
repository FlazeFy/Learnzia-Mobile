import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/EditClass.dart';
import 'package:learnzia/Firebase/Classroom/GetClassname.dart';
import 'package:learnzia/Firebase/Classroom/GetContactToInvite.dart';
import 'package:learnzia/Firebase/Classroom/GetMember.dart';
import 'package:learnzia/Widgets/sidebar.dart';
import 'package:learnzia/main.dart';

class ManageClassPage extends StatefulWidget {
  const ManageClassPage({Key key, this.passIdClass}) : super(key: key);
  final String passIdClass;

  @override
  _ManageClassPageState createState() => _ManageClassPageState();
}

class _ManageClassPageState extends State<ManageClassPage> with SingleTickerProviderStateMixin {
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
        actions: [
          GestureDetector(
            onTap: (){
              //
            },
            child: Container(
              width: fullWidth*0.75,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [ 
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/User.jpg', width: 40),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetClassname(passDocumentId: widget.passIdClass, textColor: const Color(0xFF010C10)),
                      const Text("Manage Channel", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF7289DA), fontSize: 15))
                    ]
                  )
                ]
              )    
            )
          ),
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.transparent,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.home),
              color: containerColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NavBar()),
                );
              },
            ),
          ),
        ],  
        backgroundColor: mainColor,
        bottom: TabBar(
          indicatorColor: const Color(0xFF7289DA),
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.edit, color: containerColor),
            ),
            Tab(
              icon: Icon(Icons.person, color: containerColor),
            ),
            Tab(
              icon: Icon(Icons.settings, color: containerColor),
            ),
          ],
        ),
      ),
      drawer: NavDrawer(passIdClass: widget.passIdClass),

      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: ListView(
              padding: const EdgeInsets.only(top: 0, left: 10),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Edit Classroom", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                EditClass(passIdClass: widget.passIdClass),
              ], 
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: fullHeight,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Member", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Flexible(
                  child: GetMember(passIdClass: widget.passIdClass)
                )
              ], 
            ),
          ),

          Container(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            height: fullHeight,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Send Invite", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Flexible(
                  child: GetContactToInvite(passIdClass: widget.passIdClass)
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Leave Classroom", style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                
              ], 
            ),
          )

        ]
      )
          
    );
    
  }
}