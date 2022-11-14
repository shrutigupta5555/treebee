import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class NewTree extends StatefulWidget {
  @override
  _NewTreeState createState() => _NewTreeState();
}

class _NewTreeState extends State<NewTree> {
  String? place, date, time, total_slots;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  Widget drawer() {
    return Drawer();
  }

  @override
  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu_outlined),
                    alignment: Alignment.topLeft,
                    color: Colors.black,
                    onPressed: () {
                      drawer();
                    },
                  ),
                  Text(
                    'Food Indeed',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  // Image.asset(
                  //   "assets/logo.png",
                  //   width: 62,
                  //   height: 54,
                  // )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Start Food Group",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(25, 29, 49, 1),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: <Color>[
                                Color(0xffEB271A),
                                Color(0xffFF7A00),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: TextField(
                              cursorColor: Colors.white,
                              cursorHeight: 24,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                              onChanged: (value) {
                                place = value;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Place",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: <Color>[
                                Color(0xffEB271A),
                                Color(0xffFF7A00),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: TextField(
                              cursorColor: Colors.white,
                              cursorHeight: 24,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                              onChanged: (value) {
                                date = value;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Date",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: <Color>[
                                Color(0xffEB271A),
                                Color(0xffFF7A00),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: TextField(
                              cursorColor: Colors.white,
                              cursorHeight: 24,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                              onChanged: (value) {
                                time = value;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Time",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: <Color>[
                                Color(0xffEB271A),
                                Color(0xffFF7A00),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: TextField(
                              cursorColor: Colors.white,
                              cursorHeight: 24,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                              onChanged: (value) {
                                total_slots = value;
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: "Total slots",
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              colors: <Color>[
                                Color(0xffEB271A),
                                Color(0xffFF7A00),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: InkWell(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Add Image',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: MaterialButton(
                          color: Color(0xffEB271A),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
