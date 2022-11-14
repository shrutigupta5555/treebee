import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treebee/screens/check_map.dart';
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
      backgroundColor: Color.fromARGB(255, 44, 81, 46),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TREEBEE",
                    style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Giving trees their identity",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              )),
          Container(
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(
                    "https://p1.pxfuel.com/preview/788/447/744/canopy-green-leaves-branches.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      minWidth: 170,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MapSample())));
                      },
                      child: Text(
                        "View Tree Map",
                        style: TextStyle(
                            color: Color.fromARGB(255, 50, 93, 51),
                            fontSize: 18),
                      ),
                      color: Colors.white,
                    ),
                    MaterialButton(
                      minWidth: 170,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Signup())));
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Color.fromARGB(255, 50, 93, 51),
                            fontSize: 18),
                      ),
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
