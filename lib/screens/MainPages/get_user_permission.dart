import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
//import 'package:location/location.dart' as location;

class GetUserPermission extends StatefulWidget {
  const GetUserPermission({Key? key}) : super(key: key);

  @override
  _GetUserPermissionState createState() => _GetUserPermissionState();
}

class _GetUserPermissionState extends State<GetUserPermission> {
  geolocator.Position? _currentPosition = null;

  void getLocation() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    print("Checking is enagled");
    // Test if location services are enabled.
    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    print("Done Checking is enagled");

    print("Getting location...");
    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      print("denied");
      print("requesting...");
      permission = await geolocator.Geolocator.requestPermission();
      print("dont requesting...");
      if (permission == geolocator.LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print("getting loc");
    geolocator.Position position =
        await geolocator.Geolocator.getCurrentPosition(
            desiredAccuracy: geolocator.LocationAccuracy.high);

    print(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text(
                  "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}"),
            ElevatedButton(
              child: Text("Get location"),
              onPressed: () {
                getLocation();
              },
            ),
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator.Geolocator.getCurrentPosition(
            desiredAccuracy: geolocator.LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((geolocator.Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}


// <key>NSLocationAlwaysUsageDescription</key>
// <string>This app needs access to location when in the background</string>
// <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
// <string>This app needs access to location when in the background</string>