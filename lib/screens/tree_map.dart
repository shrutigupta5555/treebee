import 'package:flutter/material.dart';

class TreeMap extends StatefulWidget {
  const TreeMap({super.key});

  @override
  State<TreeMap> createState() => _TreeMapState();
}

class _TreeMapState extends State<TreeMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("tree map"),
      ),
    );
  }
}
