import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fullHeight= MediaQuery.of(context).size.height;
    double fullWidth= MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: fullHeight,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 50, bottom: 10),
                  child: Text("Welcome Back!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: mainColor))
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              child: const Text("A lot of new things have happened since you left", style: TextStyle(fontSize: 14, color: Colors.white))
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children:[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Username", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: _usernameCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFF5A5d5e),
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Password", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Color(0xFF5A5d5e),
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forget Password?", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF7289DA))),
                  ),
                ]
              )
            ),
            Container(
              width: 140,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  
                },
                child: const Text('Log In'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  )
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:fullHeight*0.05),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: mainColor,
                          height: 36,
                          thickness: 1,
                        )
                      ),
                    ),
                    Text("Or continue with", style: TextStyle(color: mainColor)),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(
                          color: mainColor,
                          height: 36,
                          thickness: 1,
                        )
                      ),
                    ),
                  ]),
                ]
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
              child: Row(
                children: [
                  Ink(
                    decoration: ShapeDecoration(
                      color: mainColor,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.android),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                  const Spacer(),
                  Ink(
                    decoration: ShapeDecoration(
                      color: mainColor,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.android),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
              child: Row(
                children: [
                  Text("Not a member?", style: TextStyle(color: mainColor)),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                        // Respond to button press
                    },
                    child: const Text("Get Started", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF7289DA))),
                  )
                ],
              )
            )
           
          ]
        )
      ),

    );
  }
}