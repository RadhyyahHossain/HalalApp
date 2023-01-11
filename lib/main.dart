import 'package:flutter/material.dart';
import 'package:halalapp/screens/onboarding_screen.dart';
import 'screens/login_page.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/onboarding",
      routes: {
        "/login": (context) => LoginPage(),
        "/home": (context) => Scaffold(
              body: Center(child: Text("Home")),
            ),
        "/onboarding": (context) => OnboardingScreen(),
      },
    );
  }
}
