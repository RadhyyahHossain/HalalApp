import 'package:flutter/material.dart';
import 'package:halalapp/components/borough_list.dart';
import 'package:halalapp/components/bottom_navbar.dart';
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
        ],
      ),
    );
  }

  AnimatedContainer BoroughPicker() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: Expanded(
        child: ListView.builder(
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
      ),
    );
  }
}
