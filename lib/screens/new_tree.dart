import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:treebee/screens/home.dart';

class NewTree extends StatefulWidget {
  @override
  _NewTreeState createState() => _NewTreeState();
}

class _NewTreeState extends State<NewTree> {
  String? name, lat, long, created_by;
  int status = 0;
  XFile? _image;
  Position? _currentPosition;
  final ImagePicker _picker = ImagePicker();
  CollectionReference trees = FirebaseFirestore.instance.collection('trees');

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

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print("----");
      print(position);
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void addTree() {
    var x = String.fromCharCodes(
        List.generate(8, (index) => Random().nextInt(33) + 89));
    // Call the user's CollectionReference to add a new user
    _getCurrentPosition().then((value) {
      final data = {
        "name": name,
        "lat": _currentPosition?.latitude,
        "long": _currentPosition?.longitude,
        "created_by": FirebaseAuth.instance.currentUser?.email,
        "status": 0,
        "id": x,
      };

      trees.doc(x).set(data).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Home())));
      }).catchError((error) => print("Failed to add user: $error"));
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
                children: <Widget>[],
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  "Create a new tree",
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
                            color: Color.fromARGB(255, 44, 81, 46),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: TextField(
                              cursorColor: Colors.white,
                              cursorHeight: 24,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16),
                              onChanged: (value) {
                                name = value;
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "name",
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 44, 81, 46),
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
                          minWidth: 150,
                          height: 50,
                          color: Color.fromARGB(255, 44, 81, 46),
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () {
                            addTree();
                          },
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
