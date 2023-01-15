import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/home_page.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: zPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: zPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            HomeMainPage();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 150),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 10),
                      Text("Top Thai"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
