import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    print("Signed out");
    Navigator.pushReplacementNamed(this.context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SettingsItem(
                onTapMethod: () {},
                itemText: "Version 1.0",
                color: Colors.black,
              ),
              SettingsItem(
                onTapMethod: _signOut,
                itemText: "Sign Out",
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  SettingsItem(
      {Key? key,
      required this.color,
      required this.itemText,
      required this.onTapMethod})
      : super(key: key);

  Color? color;
  String itemText;
  void Function()? onTapMethod;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMethod,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 15),
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)),
        child: Text(
          itemText,
          style: TextStyle(color: color, fontSize: 15),
        ),
      ),
    );
  }
}
