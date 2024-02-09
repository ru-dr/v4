import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(23.606769, 72.999130);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Explore",
            style: Theme.of(context).textTheme.bodySmall,
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
          height: MediaQuery.of(context).size.height / 2.5,
          margin: const EdgeInsets.all(10.0), // Add some margin if you want
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(20.0), // This makes the corners rounded
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                20.0), // This clips the child widget (GoogleMap) to the rounded corners
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
  }
}
