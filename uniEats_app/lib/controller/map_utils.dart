import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math.dart';

class MapUtils {
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission permission;
  Position position;
  String lat = '', long = '';
  StreamSubscription<Position> positionStream;

  MapUtils() {}

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Future<Position> checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

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
      }

      if (haspermission) {
        return getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    return Position(longitude: null, latitude: null);
  }

  Future<Position> getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    this.long = position.longitude.toString();
    this.lat = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    return position;
  }

  double getKmToCurLocation(double latitude, double longitude) {
    double lat1 = radians(double.parse(this.lat));
    double lon1 = radians(double.parse(this.long));

    double lat2 = radians(latitude);
    double lon2 = radians(longitude);

    // Haversine formula
    double dlon = lon2 - lon1;
    double dlat = lat2 - lat1;
    double a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);

    double c = 2 * asin(sqrt(a));

    double r = 6371;

    // calculate the result
    double res = c * r;

    return res;
  }
}
