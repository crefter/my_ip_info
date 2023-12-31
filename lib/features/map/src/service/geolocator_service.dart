import 'package:geolocator/geolocator.dart';
import 'package:my_ip_info/features/map/src/exception/geolocation_denied_exception.dart';

class GeolocatorService {
  Future<(double lat, double lon)> getPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw GeolocationDeniedException('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw GeolocationDeniedException(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    return (position.latitude, position.longitude);
  }

  Future<bool> isServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }
}
