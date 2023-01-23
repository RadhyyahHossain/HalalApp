import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/screens/Authentication/authenticationPage_loginSignup.dart';
import 'package:halalapp/screens/Authentication/login_page.dart';

class mapScreen extends StatefulWidget {
  mapScreen({super.key});

  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    print("Signed out");
    Navigator.pushReplacementNamed(this.context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _signOut,
          child: const Text('sign out'),
        ),
      ),
    );
  }
}
