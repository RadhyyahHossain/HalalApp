import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/screens/MainPages/screen_router.dart';

class EnterApp extends StatefulWidget {
  const EnterApp({super.key});

  @override
  State<EnterApp> createState() => _EnterAppState();
}

class _EnterAppState extends State<EnterApp> {
  late Future<List<Resturant>> resurants;

  // Future<List<Resturant>> getRes() async {
  //   List<Resturant> allRes = [];
  //   await FirebaseFirestore.instance.collection('resv2').get().then(
  //         (snapshot) => snapshot.docs.forEach((document) {
  //           Map<String, dynamic> myData = document.data();

  //           allRes.add(Resturant(
  //               name: myData['name'],
  //               address: myData['address'],
  //               price: myData['price'],
  //               phoneNumber: myData['phone'],
  //               image: myData['image'],
  //               description: myData['description'],
  //               borough: myData['borough'],
  //               latitude: myData['latitude'],
  //               longitude: myData['longitude']));
  //         }),
  //       );
  //   return allRes;
  // }

  // get the resturants from json
  Future<List<Resturant>> readJsonData() async {
    final String response = await rootBundle.loadString('data.json');

    final data = jsonDecode(response);
    print(data);
    List<Resturant> rl = [];
    for (var value in data) {
      var r = Resturant(
        address: value["address"],
        borough: value["borough"],
        phoneNumber: value["phoneNumber"],
        description: value["description"],
        image: value['image'],
        latitude: value['latitude'].toString(),
        longitude: value['longitude'].toString(),
        name: value['name'],
        price: value['price'],
        //provider: value['provider'],
      );
      rl.add(r);
    }
    print(rl);
    return rl;
  }

  @override
  void initState() {
    resurants = readJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: resurants,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ScreenRouter(
            resturants: snapshot.data!,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
