import 'package:flutter/material.dart';

import '../constants.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;

  const MyButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
