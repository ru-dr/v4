import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Position? currentPosition;
  var isLoading = false.obs;

  String? currentLocation;

  Future<Position> getPosition() async {
    LocationPermission? permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAdressFromLatLng(long, lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      Placemark place = placemark[0];
      currentLocation =
          "${place.locality}, ${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      update();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentLocation() async {
    try{
      isLoading(true);
      update();
      currentPosition = await getPosition();
      getAdressFromLatLng(currentPosition!.longitude, currentPosition!.latitude);

      isLoading(false);
      update();
    } catch (e) {
      print(e);
    }
  }
}