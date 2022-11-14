import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:treebee/screens/home.dart';
import 'package:treebee/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

String em = "";
String nm = "";

class _SignupState extends State<Signup> {
  String email = "";
  String password = "";
  String name = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(207, 223, 224, 1)),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Get Started",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(237, 255, 253, 253),
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: width,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "name"),
                                    onChanged: (e) {
                                      name = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(237, 255, 253, 253),
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: width,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "email"),
                                    onChanged: (e) {
                                      email = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(237, 255, 253, 253),
                              borderRadius: BorderRadius.circular(10)),
                          height: 60,
                          width: width,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: TextField(
                                    obscureText: true,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "password"),
                                    onChanged: (e) {
                                      password = e;
                                    }),
                              ))),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          height: 50,
                          minWidth: 200,
                          color: Color.fromARGB(255, 235, 121, 93),
                          child: Text("register"),
                          onPressed: () async {
                            setState(() {
                              em = email;
                              nm = name;
                            });
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((value) => {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ))
                                    })
                                .catchError((err) {
                              print(err.message);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(err.message),
                                      actions: [
                                        TextButton(
                                          child: Text("okay"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            });
                          }),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Already have an acc? Sign in",
                          style: TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}
