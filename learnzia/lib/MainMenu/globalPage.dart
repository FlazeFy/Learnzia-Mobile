import 'package:flutter/material.dart';

class GlobalPage extends StatefulWidget {
  const GlobalPage({Key key}) : super(key: key);

  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: const [

          ]
        )
      ),

    );
  }
}