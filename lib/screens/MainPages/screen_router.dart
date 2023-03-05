import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/MapScreen.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:halalapp/screens/MainPages/settings_screen.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({Key? key}) : super(key: key);

  @override
  _ScreenRouterState createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  List<Widget> pages = [
    HomeMainPage(),
    MapScreen(),
    SettingsScreen(),
  ];

  int _selected_page = 0;

  void changePage(page_tapped) {
    setState(() {
      _selected_page = page_tapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selected_page],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _selected_page,
        selectedItemColor: kPrimaryColor,
        onTap: changePage,
      ),
    );
  }
}
