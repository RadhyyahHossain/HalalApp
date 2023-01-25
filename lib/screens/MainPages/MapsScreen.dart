import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halalapp/constants.dart';

const LatLng currentLocation = LatLng(40.8448, 73.8648);

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  //final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  static LatLng _curLocation = const LatLng(37.33500926, -122.03272188);
  static LatLng _destination = const LatLng(37.33429383, -122.06600055);

  //List<LatLng> polylineCoordinates = [];

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = polylinePoints.getRouteBetweenCoordinates(
  //     googleApiKey,
  //     PointLatLng(currentLocation.latitude, currentLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  // }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "HalalApp",
          style: TextStyle(
            color: Colors.red,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: _curLocation,
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: MarkerId("currentPin"),
            position: _curLocation,
          ),
          Marker(
            markerId: MarkerId("destinationPin"),
            position: _destination,
          ),
        },
      ),
    );
  }
}
