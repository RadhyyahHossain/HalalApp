import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon1 = BitmapDescriptor.defaultMarker;
  // Set<Marker> markers = {
  //   Marker(
  //     markerId: MarkerId("demo"),
  //     position: LatLng(37.422131, -122.084801),
  //     draggable: true,
  //     onDragEnd: (value) {
  //       // value is the new position
  //     },
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   ),
  // };

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/icons8-male-user-55.png")
        .then(((icon) {
      print("setting state...");
      setState(() {
        markerIcon1 = icon;
      });
      print("Done setting state");
    }));
  }

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.422131, -122.084801),
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId("demo"),
            position: LatLng(37.422131, -122.084801),
            draggable: true,
            infoWindow: InfoWindow(title: "Your Location"),
            onDragEnd: (value) {
              // value is the new position
            },
            icon: markerIcon1,
          ),
        },
      ),
    );
  }
}
