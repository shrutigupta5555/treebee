import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:treebee/main.dart';
import 'package:treebee/screens/new_tree.dart';
import 'package:treebee/screens/tree_profile.dart';
import 'dart:ui' as ui;

String currentTree = "";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  // Position? _currentPosition = Position(longitude: 37.42796133580664, latitude:  -122.085749655962);
  Position? _currentPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  @override
  void initState() {
    _getCurrentPosition();
    getAdoptedTrees();
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
        .then((Position position) async {
      print(position);
      setState(() => _currentPosition = position);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(position.latitude, position.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414)));
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void getAdoptedTrees() async {
    var x = await FirebaseFirestore.instance.collection("trees").get();
    var y = x.docs.map((doc) => doc.data()).toList();
    var email = FirebaseAuth.instance.currentUser!.email;
    log(email.toString());
    print("hehe");

    setState(() {
      adoptedTrees = y;
      userAdoptedTrees =
          y.where((score) => score["created_by"] == email).toList();
    });

    addMarkers(y);
    // log(y.toString());
  }

  var adoptedTrees = [];
  var userAdoptedTrees = [];

  void addMarkers(hehe) async {
    for (var element in hehe) {
      log(element["status"].toString());
      log((element["status"] == 0).toString());
      Uint8List markerIcon = await getBytesFromAsset(
          element["status"] != 0
              ? 'assets/images/normal.png'
              : 'assets/images/autumn.png',
          100);
      markers.add(Marker(
          onTap: () {
            setState(() {
              currentTree = element["id"];
            });

            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TreeProfile())));
          },
          markerId: MarkerId(element["id"]),
          // markerId: element["id"],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          position: LatLng(element["lat"], element["long"])));
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  final Set<Marker> markers = Set(); //markers for google map

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
                color: Colors.white,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    zoom: 1,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: markers,
                ),
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
                height: userAdoptedTrees.length * 60,
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
                                onTap: () async {
                                  setState(() {
                                    currentTree = adoptedTrees[index]["id"];
                                  });
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
