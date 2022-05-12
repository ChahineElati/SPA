import 'package:geolocator/geolocator.dart';

bool servicestatus = false;
bool haspermission = false;

checkGps() async {
  servicestatus = await Geolocator.isLocationServiceEnabled();
  if (servicestatus) {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
      } else {
        haspermission = true;
      }
    } else {
      haspermission = true;
      return getLocation();
    }
  }
}

getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}
