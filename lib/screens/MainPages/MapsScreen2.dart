import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/constants.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  //location tracking
  String locationMessage = "current location";

  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng curLocation = const LatLng(37.33500926, -122.03272188);
  static const LatLng destination = const LatLng(37.33429383, -122.06600055);
  List<LatLng> polylineCoordinates = [];

  late String lat;
  late String long;

  Future<BitmapDescriptor> addUserIcon() async {
    var val = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)), "burger.jpg");
    setState(() {
      userIcon = val;
    });
    return val;
  }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     apiKey,
  //     PointLatLng(curLocation.latitude, curLocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach(
  //       (PointLatLng point) => polylineCoordinates.add(
  //         LatLng(point.latitude, point.longitude),
  //       ),
  //     );
  //     setState(() {});
  //   }
  // }

  //test
  late Set<Marker> multiMarkers = {};

  //current loaction
  // Future<Position> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error("Location servicess are diabled");
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error("location denied. Can't request permission");
  //     }
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  void initState() {
    initalize();
    addUserIcon();
    //getPolyPoints();
    super.initState();
  }

  initalize() {
    Marker first = Marker(
      markerId: MarkerId("place"),
      position: LatLng(37.33429370, -122.06600050),
      infoWindow: InfoWindow(title: "place1"),
      icon: BitmapDescriptor.defaultMarker,
    );
    Marker second = Marker(
      markerId: MarkerId("place2"),
      position: curLocation,
      infoWindow: InfoWindow(title: "place2"),
      icon: BitmapDescriptor.defaultMarker,
    );
    Marker third = Marker(
      markerId: MarkerId("place3"),
      position: curLocation,
      infoWindow: InfoWindow(title: "place3"),
      icon: BitmapDescriptor.defaultMarker,
    );
    Marker fourth = Marker(
      markerId: MarkerId("place4"),
      position: destination,
      infoWindow: InfoWindow(title: "place4"),
      icon: BitmapDescriptor.defaultMarker,
    );
    multiMarkers.add(first);
    multiMarkers.add(second);
    multiMarkers.add(third);
    multiMarkers.add(fourth);

    setState(() {});
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<BitmapDescriptor>(
        future: addUserIcon(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GoogleMapWidget(
                curLocation: curLocation,
                polylineCoordinates: polylineCoordinates,
                userIcon: userIcon,
                destination: destination,
                userMarker: snapshot.data,
                multiMarkers: multiMarkers);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     _getCurrentLocation().then((value) async {
      //       lat = "${value.latitude}";
      //       long = "${value.longitude}";
      //       // _liveLocation();
    );
  }
}

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    Key? key,
    required this.curLocation,
    required this.polylineCoordinates,
    required this.userIcon,
    required this.destination,
    required this.userMarker,
    required this.multiMarkers,
  }) : super(key: key);

  final LatLng curLocation;
  final List<LatLng> polylineCoordinates;
  final BitmapDescriptor userIcon;
  final LatLng destination;
  final BitmapDescriptor userMarker;
  final Set<Marker> multiMarkers;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: curLocation,
        zoom: 10,
      ),
      polylines: {
        Polyline(
          polylineId: PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.red.shade400,
          width: 6,
        )
      },
      markers: multiMarkers,
    );
  }
}
