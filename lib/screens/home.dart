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
  var adoptedTrees = [
    {
      "id": "123",
      "name": "aamkash",
      "photo": "",
      "status": "not adopted",
      "latlong": [],
    },
    {
      "id": "123",
      "name": "aamkash",
      "photo": "",
      "status": "not adopted",
      "latlong": [],
    },
    {
      "id": "123",
      "name": "aamkash",
      "photo": "",
      "status": "not adopted",
      "latlong": [],
    },
    {
      "id": "123",
      "name": "aamkash",
      "photo": "",
      "status": "not adopted",
      "latlong": [],
    }
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color.fromARGB(255, 44, 81, 46),
          ),
          title: Text(
            "Home",
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 44, 81, 46),
            ),
          ),
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
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Adopted Trees",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: adoptedTrees.length * 60,
                child: ListView.builder(
                    itemCount: adoptedTrees.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListTile(
                              leading: const Icon(
                                Icons.nature_people,
                                color: Colors.green,
                              ),
                              trailing: GestureDetector(
                                child: Text(
                                  "open profile",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              TreeProfile())));
                                },
                              ),
                              title: Text(
                                  adoptedTrees[index]["name"].toString())));
                    }),
              ),
            ],
          ),
        )));
  }
}
