import 'package:flutter/material.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/MapScreen.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:halalapp/screens/MainPages/settings_screen.dart';

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({
    Key? key,
    required this.resturants,
  }) : super(key: key);

  final List<Resturant> resturants;

  @override
  _ScreenRouterState createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  List<Widget> pages = [];

  int _selected_page = 0;

  void changePage(page_tapped) {
    setState(() {
      _selected_page = page_tapped;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    pages = [
      HomeMainPage(resturants: widget.resturants),
      MapScreen(resturants: widget.resturants),
      SettingsScreen(),
    ];
    super.initState();
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
