import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
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

    await FirebaseFirestore.instance.collection('resturants').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              Map<String, dynamic> myData = document.data();

              var name = myData['name'];
              var address = myData['address'];
              var price = myData['price'];
              var phoneNumber = myData['phone'];
              var image = myData['image'];
              var description = myData['description'];
              var borough = myData['borough'];
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

              allMarkers.add(Marker(
                markerId: MarkerId(name),
                position: LatLng(37.422131, -122.084801),
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

  @override
  void initState() {
    getMarkers();
    addCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
        markerId: MarkerId("demo"),
        position: LatLng(37.422131, -122.084801),
        infoWindow: InfoWindow(title: "Your Location"),
        icon: markerIcon1,
      ),
    );

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(37.422131, -122.084801),
        zoom: 14,
      ),
      markers: allMarkers,
    );
  }
}
