import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          child: Column(children: [
            SettingsItem(
              itemName: "Version: 1.0",
              itemColor: Colors.black,
              onTapMethod: () {},
            ),
            SettingsItem(
                itemName: "Sign Out",
                itemColor: Colors.red[400],
                onTapMethod: _signOut),
          ]),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  SettingsItem(
      {Key? key,
      required this.itemName,
      required this.itemColor,
      required this.onTapMethod})
      : super(key: key);
  String itemName;
  Color? itemColor;
  void Function()? onTapMethod;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapMethod,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          itemName,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: itemColor,
          ),
        ),
      ),
    );
  }
}
