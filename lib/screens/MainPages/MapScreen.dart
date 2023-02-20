import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/screens/MainPages/better_detailsPage.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon1 = BitmapDescriptor.defaultMarker;

  LatLng? currentLocation;

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentLocation = LatLng(position.latitude, position.longitude);
    // Location location1 = Location();
    // location1.getLocation().then((location1) {
    //   currentLocation = location1;
    // });
  }

  Route _createRoute(Resturant currentRes) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BetterDetailsPage(currentRes: currentRes),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Future getMarkers() async {
    Set<Marker> allMarkers = {};

    await FirebaseFirestore.instance.collection('resv2').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              Map<dynamic, dynamic> myData = document.data();

              var name = myData['name'];
              var address = myData['address'];
              var price = myData['price'];
              var phoneNumber = myData['phone'];
              var image = myData['image'];
              var description = myData['description'];
              var borough = myData['borough'];
              var latitude1 = myData['latitude'];
              var longitude1 = myData['longitude'];
              print(name);

              Resturant currentRes = Resturant(
                name: name,
                address: address,
                price: price,
                phoneNumber: phoneNumber,
                image: image,
                description: description,
                borough: borough,
              );

              double lat = double.parse(latitude1);
              double lng = double.parse(longitude1);

              allMarkers.add(Marker(
                markerId: MarkerId(name),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: name),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) => BetterDetailsPage(
                  //       currentRes: currentRes,
                  //     ),
                  //   ),
                  // );

                  Navigator.of(context).push(_createRoute(currentRes));
                },
              ));
            },
          ),
        );
    return allMarkers;
  }

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

  void requestUserPermission() async {
    await Geolocator.requestPermission()
        .then(
      (value) {},
    )
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    getMarkers();
    addCustomIcon();
    requestUserPermission();
    //getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(
              child: Text("loading"),
            )
          : FutureBuilder(
              future: getMarkers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return OurGoogleMap(
                    allMarkers: snapshot.data,
                    markerIcon1: markerIcon1,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
    );
  }
}

class OurGoogleMap extends StatelessWidget {
  static const CameraPosition _curPosition = CameraPosition(
    target: LatLng(40.7484, -73.9857),
    zoom: 12,
  );

  const OurGoogleMap({
    Key? key,
    required this.allMarkers,
    required this.markerIcon1,
  }) : super(key: key);

  final Set<Marker> allMarkers;
  final BitmapDescriptor markerIcon1;

  @override
  Widget build(BuildContext context) {
    allMarkers.add(
      Marker(
        markerId: MarkerId("user"),
        position: LatLng(40.7484, -73.9857),
        infoWindow: InfoWindow(title: "Your Location"),
        icon: markerIcon1,
      ),
    );

    return GoogleMap(
      initialCameraPosition: _curPosition,
      markers: allMarkers,
    );
  }
}
