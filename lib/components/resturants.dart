import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';

class Resturants extends StatelessWidget {
  final String names;

  const Resturants({
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 100,
        color: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Text(
            names,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
