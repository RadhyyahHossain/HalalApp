import 'package:flutter/material.dart';
import 'package:halalapp/screens/Authentication/login_page.dart';
import 'package:halalapp/screens/Authentication/signup_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return signUpPage(
        showLoginPage: toggleScreens,
      );
    }
  }
}
