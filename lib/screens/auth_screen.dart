import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/screens/list_screen.dart';
import 'package:halalapp/screens/login_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if logged in
          if (snapshot.hasData) {
            return ListScreen();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
