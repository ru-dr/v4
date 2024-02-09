import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final Completer<GoogleMapController> _controller = Completer();
  double mapHeight = 0;
  bool isFullScreen = false;

  static const LatLng _center = LatLng(23.606769, 72.999130);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapHeight = MediaQuery.of(context).size.height / 2.5;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

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
        ),
      ),
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(
                seconds: 1), // Increase the duration to 2 seconds
            curve: Curves.ease, // Use the ease curve for a smoother animation
            height: mapHeight,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 -
                25, // Center the button horizontally
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isFullScreen = !isFullScreen;
                  mapHeight = isFullScreen
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height / 2.5;
                });
              },
              child: isFullScreen
                  ? SvgPicture.asset('assets/SVG/Pill_up.svg')
                  : SvgPicture.asset('assets/SVG/Pill_down.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
