import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/components/borough_name.dart';
import 'package:halalapp/components/bottom_navbar.dart';
import 'package:halalapp/components/main_resturantList.dart';
import 'package:halalapp/components/resturants.dart';
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
  List<String> docIDs = [];

  //get info
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('resturants').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  void initState() {
    getDocId();
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
      bottomNavigationBar: bottomNavBar(),
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
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView(
                  children: <Widget>[
                    resturantList(),
                    resturantList(),
                    resturantList(),
                    resturantList(),
                    resturantList()
                  ],
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
