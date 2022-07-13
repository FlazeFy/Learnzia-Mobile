import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:learnzia/MainMenu/contactPage.dart';
import 'package:learnzia/MainMenu/globalPage.dart';
import 'package:learnzia/MainMenu/homePage.dart';
import 'package:learnzia/MainMenu/profilePage.dart';

void main() {
    runApp(const MyApp());
}
class MyApp extends StatelessWidget {
    const MyApp({Key key}) : super(key: key);
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF313436)),
      home: const NavBar(),
    );
    }
}

class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);
  
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      HomePage(),
      ContactPage(),
      GlobalPage(),
      ProfilePage(),
    ];
    return Scaffold(
    bottomNavigationBar: CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        const Icon(Icons.home, size: 30, color: Color(0xFF313436)),
        const Icon(Icons.chat, size: 30, color: Color(0xFF313436)),
        const Icon(Icons.public, size: 30, color: Color(0xFF313436)),
        ClipOval(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(18), // Image radius
            child: Image.asset('assets/images/User.jpg', fit: BoxFit.cover),
          ),
        ),
      ],
      color: Colors.white.withOpacity(0.2),
      buttonBackgroundColor: Color(0xFFF1C40F).withOpacity(0.9),
      backgroundColor: Colors.white.withOpacity(0),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
      letIndexChange: (index) => true,
    ),
    body: _widgetOptions.elementAt(_page)
    );
  }
}