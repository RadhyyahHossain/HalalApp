import 'package:flutter/material.dart';
import 'package:halalapp/constants.dart';

class bottomNavBar extends StatelessWidget {
  const bottomNavBar({
    Key? key,
  }) : super(key: key);

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
              color: Color.fromARGB(255, 232, 181, 161).withOpacity(0.25)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.home,
                color: kPrimaryColor,
              )),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
        ],
      ),
    );
  }
}
