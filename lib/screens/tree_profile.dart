import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:treebee/screens/home.dart';

class TreeProfile extends StatefulWidget {
  const TreeProfile({super.key});

  @override
  State<TreeProfile> createState() => _TreeProfileState();
}

class _TreeProfileState extends State<TreeProfile> {
  Map<String, dynamic>? treedata = {};
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("trees")
        .doc(currentTree)
        .get()
        .then((value) => {
              setState(() {
                treedata = value.data();
              })
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Tree Profile",
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 44, 81, 46),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: w - 40,
                    width: w - 40,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://images.hindustantimes.com/rf/image_size_630x354/HT/p2/2017/04/10/Pictures/_f5c4f41e-1dc7-11e7-89d6-c3c500e93e5a.jpg",
                            ),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name - ${treedata!['name']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "latitude: ${treedata!['lat']}, longitude: ${treedata!['long']}"),
                          Text(
                            "Status - ${treedata!['status'] != 0 ? 'Adopted' : 'Not Adopted'}",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: treedata!["status"] == 0
                        ? () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Container(
                                          height: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  "You agree to-\n1. Take care of the tree throughout.\n2. Protect it from animals and miscreants.\n3. Drop adoption if you feel like you're not able to give enough time"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              MaterialButton(
                                                onPressed: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("trees")
                                                      .doc(currentTree)
                                                      .update({
                                                    "created_by": FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .email,
                                                    "status": 1
                                                  });
                                                  Navigator.pop(context);
                                                  FirebaseFirestore.instance
                                                      .collection("trees")
                                                      .doc(currentTree)
                                                      .get()
                                                      .then((value) => {
                                                            setState(() {
                                                              treedata =
                                                                  value.data();
                                                            })
                                                          });
                                                },
                                                child: Text("Confirm Adoption"),
                                                height: 50,
                                                minWidth: 200,
                                                color: Colors.green,
                                              ),
                                            ],
                                          )),
                                    ));
                          }
                        : () {},
                    child: Text(
                        treedata!["status"] == 0 ? "Adopt" : "Already Adopted"),
                    height: 50,
                    minWidth: w - 40,
                    color: Colors.green,
                  ),
                ],
              ))),
    );
  }
}
