import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(23.606769, 72.999130);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        "Explore",
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff)),
      ),
      backgroundColor: const Color(0xff0E1219),
      iconTheme: const IconThemeData(color: Color(0xffffffff)),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
    body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height/2.5,
        margin: EdgeInsets.all(10.0), // Add some margin if you want
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), // This makes the corners rounded
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), // This clips the child widget (GoogleMap) to the rounded corners
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
        ),
      ),
    ),
  );
}}