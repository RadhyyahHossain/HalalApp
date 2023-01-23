import 'package:flutter/material.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/components/image_carousel.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsScreen extends StatelessWidget {
  Resturant currentRes;
  DetailsScreen({super.key, required this.currentRes});

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
            Navigator.pop(
              context,
              //DetailsScreen(builder: (context) => HomeMainPage()),
            );
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
                  shopName(boroughLocation: "Manhattan"),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              currentRes.name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Rating: ${currentRes.rating}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "\$ ${currentRes.price}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.only(right: 210),
                    child: Text(
                      currentRes.address,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  carouselImage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row shopName({required String boroughLocation}) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.grey[400],
        ),
        SizedBox(width: 10),
        Text(
          boroughLocation,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
