import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/screens/login_page.dart';

class mapScreen extends StatelessWidget {
  mapScreen({super.key});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text('sign out'),
        ),
      ),
    );
  }
}
