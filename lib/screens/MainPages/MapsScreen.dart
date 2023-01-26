import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/constants.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng curLocation = const LatLng(37.33500926, -122.03272188);
  static const LatLng destination = const LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  //LocationData? currentLocation;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(curLocation.latitude, curLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
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
        initialCameraPosition: CameraPosition(
          target: curLocation,
          zoom: 13,
        ),
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.red.shade400,
            width: 6,
          )
        },
        markers: {
          Marker(
            markerId: MarkerId("currentPin"),
            position: curLocation,
            infoWindow: InfoWindow(
              title: "Me",
            ),
          ),
          Marker(
            markerId: MarkerId("destinationPin"),
            position: destination,
            infoWindow: InfoWindow(
              title: "current res title",
              snippet: "address",
            ),
          ),
        },
      ),
    );
  }
}
