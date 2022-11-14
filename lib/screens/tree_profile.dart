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
      body: SafeArea(
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Text("Tree Profile"),
                  Container(
                    height: w - 60,
                    width: w - 60,
                    color: Colors.blueGrey,
                  ),
                  Text("Name - HEHE"),
                  Text("exists on db since 1 November, 2022"),
                  Text("Status - Adopted"),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Container(
                                  child: Text("hehe"),
                                ),
                              ));
                    },
                    child: Text("Adopt"),
                    height: 50,
                    minWidth: w - 60,
                    color: Colors.green,
                  ),
                ],
              ))),
    );
  }
}
