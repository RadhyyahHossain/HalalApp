import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/screens/MainPages/better_detailsPage.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.resturants});

  final List<Resturant> resturants;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor markerIcon1 = BitmapDescriptor.defaultMarker;

  //LatLng? currentLocation;
  late Future<LocationData?> _locationData;
  Set<Marker> allMarkers = {};

  // void getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   currentLocation = LatLng(position.latitude, position.longitude);
  //   // Location location1 = Location();
  //   // location1.getLocation().then((location1) {
  //   //   currentLocation = location1;
  //   // });
  // }

  Future<LocationData?> _determinePosition() async {
    Location location = Location();
    print("\nGetting location\n");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("not service enabled");
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("permission not granted");
        return null;
      }
    }
    var locationData = await location.getLocation();
    print("\n\n Got Location \n\n");
    print(locationData);
    setState(() {});

    //location.enableBackgroundMode(enable: true);
    return locationData;
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

  void turnResturantsToMarkers() {
    List<Resturant> res = widget.resturants;
    for (var i = 0; i < res.length; i++) {
      Resturant singleRes = res[i];

      double latDouble = double.parse(singleRes.latitude);
      double longDouble = double.parse(singleRes.longitude);

      //turn [singleRes] into a Marker
      Marker singleMarker = Marker(
        markerId: MarkerId(singleRes.name),
        position: LatLng(latDouble, longDouble),
        infoWindow: InfoWindow(title: singleRes.name),
        onTap: () {
          Navigator.of(context).push(_createRoute(singleRes));
        },
      );

      //put that new marker into  [allMarkers]
      allMarkers.add(singleMarker);
    }
  }
  // Future getMarkers() async {
  //   Set<Marker> allMarkers = {};
  //   await FirebaseFirestore.instance.collection('resv2').get().then(
  //         (snapshot) => snapshot.docs.forEach(
  //           (document) {
  //             Map<dynamic, dynamic> myData = document.data();

  //             var name = myData['name'];
  //             var address = myData['address'];
  //             var price = myData['price'];
  //             var phoneNumber = myData['phone'];
  //             var image = myData['image'];
  //             var description = myData['description'];
  //             var borough = myData['borough'];
  //             var latitude1 = myData['latitude'];
  //             var longitude1 = myData['longitude'];
  //             print(name);

  //             Resturant currentRes = Resturant(
  //               name: name,
  //               address: address,
  //               price: price,
  //               phoneNumber: phoneNumber,
  //               image: image,
  //               description: description,
  //               borough: borough,
  //             );

  //             double lat = double.parse(latitude1);
  //             double lng = double.parse(longitude1);

  //             allMarkers.add(Marker(
  //               markerId: MarkerId(name),
  //               position: LatLng(lat, lng),
  //               infoWindow: InfoWindow(title: name),
  //               onTap: () {
  //                 // Navigator.push(
  //                 //   context,
  //                 //   MaterialPageRoute<void>(
  //                 //     builder: (BuildContext context) => BetterDetailsPage(
  //                 //       currentRes: currentRes,
  //                 //     ),
  //                 //   ),
  //                 // );

  //                 Navigator.of(context).push(_createRoute(currentRes));
  //               },
  //             ));
  //           },
  //         ),
  //       );
  //   return allMarkers;
  // }

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

  // void requestUserPermission() async {
  //   await Geolocator.requestPermission()
  //       .then(
  //     (value) {},
  //   )
  //       .onError((error, stackTrace) {
  //     print("error" + error.toString());
  //   });
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     currentLocation = LatLng(position.latitude, position.longitude);
  //   });
  // }

  @override
  void initState() {
    turnResturantsToMarkers();
    addCustomIcon();
    _locationData = _determinePosition();
    //requestUserPermission();
    //getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _locationData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return OurGoogleMap(
                allMarkers: allMarkers,
                markerIcon1: markerIcon1,
                locationData: snapshot.data!);
          } else {
            return Center(
              child: Center(child: Text("Getting your location...")),
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
    required this.locationData,
  }) : super(key: key);

  final Set<Marker> allMarkers;
  final BitmapDescriptor markerIcon1;
  final LocationData locationData;

  @override
  Widget build(BuildContext context) {
    allMarkers.add(
      Marker(
        markerId: MarkerId("user"),
        position: LatLng(locationData.latitude!, locationData.longitude!),
        infoWindow: InfoWindow(title: "Your Location"),
        icon: markerIcon1,
      ),
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(locationData.latitude!, locationData.longitude!),
          zoom: 15),
      markers: allMarkers,
    );
  }
}
