import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/details_page.dart';

class bottomNavBar extends StatefulWidget {
  bottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  String _is_selected = "home";

  void setPage(String pageTapped) {
    setState(() {
      _is_selected = pageTapped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, -7),
              blurRadius: 33,
              color: Colors.grey.shade100.withOpacity(0.2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              onPressed: () {
                setPage("home");
                Navigator.pushNamed(context, "/home");
              },
              icon: Icon(
                Icons.home,
                color: _is_selected == "home" ? kPrimaryColor : Colors.black,
              )),
          IconButton(
            onPressed: () {
              setPage("search");
              Navigator.pushNamed(context, "/search");
            },
            icon: Icon(
              Icons.search,
              color: _is_selected == "search" ? kPrimaryColor : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              setPage("map");
              Navigator.pushNamed(context, "/map");
            },
            icon: Icon(
              Icons.map,
              color: _is_selected == "map" ? kPrimaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
