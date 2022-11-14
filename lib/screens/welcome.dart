import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treebee/screens/login.dart';
import 'package:treebee/screens/signup.dart';
import 'package:treebee/screens/tree_map.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
              child: Text("View tree map"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => TreeMap())));
              }),
          Text("Giving trees their identity"),
          InkWell(
              child: Text("Get started"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Signup())));
              })
        ],
      ),
    );
  }
}
