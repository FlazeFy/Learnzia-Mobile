import 'package:flutter/material.dart';
import 'package:learnzia/MainMenu/loginPage.dart';
import 'package:learnzia/main.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight= MediaQuery.of(context).size.height;
    double fullWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: fullHeight,
        child: ListView(
          children: [
            Container(
              height: 340,
              margin: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                'assets/icons/Group.png',),
              ),
              decoration: BoxDecoration(
                color: containerColor,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              )
            ),
            SizedBox(
              height: 120,
              child: ClipRRect(
                child: Image.asset(
                'assets/icons/Logo1.png'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              child: Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                          // Respond to button press
                      },
                      child: const Text('Get Started'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF7289DA)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                        )
                      )
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 140,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => const LoginPage(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
                              final curvedAnimation = CurvedAnimation(
                                parent: animation,
                                curve: Curves.ease,
                              );

                              return SlideTransition(
                                position: tween.animate(curvedAnimation),
                                child: child,
                              );
                            }
                          ),
                        );
                      },
                      child: const Text('Sign In'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          )
                        )
                      )
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("V1.0", style: TextStyle(fontSize: 11, color: Colors.white))
            ),
          ]
        )
      ),

    );
  }
}