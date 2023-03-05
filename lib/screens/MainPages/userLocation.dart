import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({super.key});

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  LocationData? _locationData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bruh"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _determinePosition,
              child: Text("determine position zesty"),
            ),
            SizedBox(height: 20),
            Text(_locationData != null
                ? "long: ${_locationData!.longitude}, lat: ${_locationData!.latitude}"
                : "none"),
          ],
        ),
      ),
    );
  }

  void _determinePosition() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("not service enabled");
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("permission not granted");
        return;
      }
    }
    _locationData = await location.getLocation();
    print(_locationData);
    setState(() {});

    location.enableBackgroundMode(enable: true);
  }
}
