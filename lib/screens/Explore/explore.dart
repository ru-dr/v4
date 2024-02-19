import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:v4/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_webservice/places.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with AutomaticKeepAliveClientMixin {
  GoogleMapController? _mapController;
  double mapHeight = 0;
  bool isFullScreen = false;
  bool isLiveLocationOn = false;

  LatLng _initialPosition = const LatLng(0, 0);

  final locationController = Get.find<LocationController>();

  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyA3wfl35CzCuXjk1wCkz64hZawNYyWjHDg');
  // Create a set of markers
  final Set<Marker> _markers = {};

  Timer? liveLocationTimer;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    locationController.getPosition().then((Position position) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    });
  }

  void updateMarker() async {
    Position position = await locationController.getPosition();

    // Add a marker to the new position
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('current_position'),
          position: LatLng(position.latitude, position.longitude),
        ),
      );
    });
  }

  void updateCameraPosition() async {
    Position position = await locationController.getPosition();

    // Get the current zoom level
    double currentZoomLevel = await _mapController?.getZoomLevel() ?? 16.0;

    // Update the map to the new position
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: currentZoomLevel,
        ),
      ),
    );
  }

  void toggleLiveLocation() {
    if (isLiveLocationOn) {
      liveLocationTimer?.cancel();
    } else {
      liveLocationTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        updateMarker();
      });
    }
    setState(() {
      isLiveLocationOn = !isLiveLocationOn;
    });
  }

  @override
  void dispose() {
    liveLocationTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mapHeight = MediaQuery.of(context).size.height / 2.5;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Add this line
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
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.ease,
            height: mapHeight,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 16.0,
                    ),
                    markers: _markers,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        toggleLiveLocation();
                        updateCameraPosition();
                      },
                      child: isLiveLocationOn
                          ? SvgPicture.asset(
                              'assets/SVG/LiveOn.svg',
                              height: 30,
                            )
                          : SvgPicture.asset(
                              'assets/SVG/LiveOff.svg',
                              height: 30,
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: GestureDetector(
                          onTap: () async {
                            Prediction? p = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: 'AIzaSyA3wfl35CzCuXjk1wCkz64hZawNYyWjHDg',
                              mode: Mode.overlay, // Mode.fullscreen
                              language: "en",
                              components: [Component(Component.country, "us")],
                            );

                            if (p != null) {
                              print('Place selected: ${p.description}');
                              // get detail (lat/lng)
                              PlacesDetailsResponse detail =
                                  await places.getDetailsByPlaceId(p.placeId!);
                              double lat = detail.result.geometry!.location.lat;
                              double lng = detail.result.geometry!.location.lng;
                              print('Place details: lat=$lat, lng=$lng');

                              // update the map
                              _mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                    target: LatLng(lat, lng),
                                    zoom: 16.0,
                                  ),
                                ),
                              );
                            } else {
                              print("Prediction is null");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(width: 8),
                                  Text("Search"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 25,
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
