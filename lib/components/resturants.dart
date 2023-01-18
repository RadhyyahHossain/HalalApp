import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';

class Resturant extends StatefulWidget {
  const Resturant({super.key});

  @override
  State<Resturant> createState() => _ResturantState();
}

class _ResturantState extends State<Resturant> {
  List<String> rest = ["thai", "lwjf", "nflkf", "ksdbk"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {}),
          ),
        ],
      ),
    );
  }
}
