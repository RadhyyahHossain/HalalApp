import 'package:flutter/material.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/components/image_carousel.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BetterDetailsPage extends StatelessWidget {
  const BetterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: zPrimaryColor,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/burger.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
