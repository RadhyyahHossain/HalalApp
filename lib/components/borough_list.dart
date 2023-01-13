import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';

class BoroughNames extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;

  const BoroughNames({
    Key? key,
    required this.title,
    this.isActive = false,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(title,
                style: isActive
                    ? TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      )
                    : TextStyle(color: Colors.grey[500], fontSize: 12)),
            if (isActive)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
