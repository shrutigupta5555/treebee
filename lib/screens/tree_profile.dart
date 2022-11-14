import 'package:flutter/material.dart';

class TreeProfile extends StatefulWidget {
  const TreeProfile({super.key});

  @override
  State<TreeProfile> createState() => _TreeProfileState();
}

class _TreeProfileState extends State<TreeProfile> {
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
                    color: Colors.blueGrey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name - HEHE",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text("latitude: 69, longitude: 69"),
                          Text(
                            "Status - Adopted",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
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
                                          onPressed: () {},
                                          child: Text("Confirm Adoption"),
                                          height: 50,
                                          minWidth: 200,
                                          color: Colors.green,
                                        ),
                                      ],
                                    )),
                              ));
                    },
                    child: Text("Adopt"),
                    height: 50,
                    minWidth: w - 40,
                    color: Colors.green,
                  ),
                ],
              ))),
    );
  }
}
