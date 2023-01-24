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
  HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  User? user = FirebaseAuth.instance.currentUser;
//RESTURANT ID
  List<Resturant> resurants = [];

  //get info
  Future getDocs() async {
    await FirebaseFirestore.instance.collection('resturants').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            Map<String, dynamic> myData = document.data();

            resurants.add(Resturant(
              name: myData['name'],
              address: myData['address'],
              price: myData['price'],
              rating: myData['rating'],
              image: myData['image'],
              description: myData['description'],
              borough: myData['borough'],
            ));
          }),
        );
  }

  @override
  void initState() {
    getDocs();
    super.initState();
  }

  List<String> boroughs = [
    "Bronx",
    "Manhattan",
    "Queens",
    "Brooklyn",
    "Staten Island"
  ];
  int _boroughIndex = 1;

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
            child: FutureBuilder(
              future: getDocs(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: resurants.length,
                  itemBuilder: (context, index) {
                    return ResturantCard(
                      res: resurants[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container BoroughPicker() {
    return Container(
      // duration: Duration(seconds: 1),
      // curve: Curves.fastOutSlowIn,
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
  }
}
