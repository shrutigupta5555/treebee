import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:treebee/main.dart';
import 'package:treebee/screens/new_tree.dart';
import 'package:treebee/screens/tree_profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => NewTree())));
                },
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) => {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: ((context) => App())),
                            (route) => false)
                      });
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 2 / 3 * h,
                width: w - 40,
                color: Colors.pink,
              ),
              InkWell(
                  child: Text("Your Adopted Trees"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => TreeProfile())));
                  })
            ],
          ),
        )));
  }
}
