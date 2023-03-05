import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/components/borough_name.dart';
import 'package:halalapp/components/resturant_card.dart';
import 'package:halalapp/components/search_box.dart';
import 'package:halalapp/constants.dart';
//import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class HomeMainPage extends StatefulWidget {
  HomeMainPage({super.key, required this.resturants});

  final List<Resturant> resturants;

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  User? user = FirebaseAuth.instance.currentUser;
//RESTURANT ID
  //late Future<List<Resturant>> resurants;

  //get info
  // Future<List<Resturant>> getRes() async {
  //   List<Resturant> allRes = [];
  //   await FirebaseFirestore.instance.collection('resv2').get().then(
  //         (snapshot) => snapshot.docs.forEach((document) {
  //           Map<String, dynamic> myData = document.data();

  //           allRes.add(Resturant(
  //             name: myData['name'],
  //             address: myData['address'],
  //             price: myData['price'],
  //             phoneNumber: myData['phone'],
  //             image: myData['image'],
  //             description: myData['description'],
  //             borough: myData['borough'],
  //           ));
  //         }),
  //       );
  //   return allRes;
  // }

  @override
  void initState() {
    //resurants = getRes();
    super.initState();
  }

  List<String> boroughs = [
    "Bronx",
    "Manhattan",
    "Queens",
    "Brooklyn",
    "Staten Island"
  ];
  int _boroughIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "HalalApp",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SearchBox(
            onChanged: (value) {},
          ),
          BoroughPicker(),
          Expanded(
            child: OurListView(
                resurants: widget.resturants,
                boroughs: boroughs,
                boroughIndex: _boroughIndex),
          ),
        ],
      ),
    );
  }

  Container BoroughPicker() {
    return Container(
      height: 65,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: boroughs.length,
        itemBuilder: ((context, index) {
          return BoroughNames(
            title: boroughs[index],
            press: () {
              setState(() {
                _boroughIndex = index;
              });
            },
            isActive: index == _boroughIndex,
          );
        }),
      ),
    );
    // AnimatedContainer(
    //   color: zPrimaryColor,
    //   curve: Curves.fastLinearToSlowEaseIn,
    //   duration: const Duration(milliseconds: 500),
    // );
  }
}

class OurListView extends StatelessWidget {
  const OurListView({
    Key? key,
    required this.resurants,
    required this.boroughs,
    required int boroughIndex,
  })  : _boroughIndex = boroughIndex,
        super(key: key);

  final List<Resturant> resurants;
  final List<String> boroughs;
  final int _boroughIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resurants.length,
      itemBuilder: (context, index) {
        var resBorough = resurants[index].borough;
        if (resBorough.toUpperCase() == boroughs[_boroughIndex].toUpperCase()) {
          return ResturantCard(
            res: resurants[index],
          );
        } else {
          return SizedBox(
            height: 0,
            width: 0,
          );
        }
      },
    );
  }
}
