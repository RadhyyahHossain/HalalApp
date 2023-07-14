import 'package:flutter/material.dart';
import 'package:halalapp/screens/Authentication/auth_screen.dart';
import 'package:halalapp/screens/MainPages/enter_app.dart';
import 'package:halalapp/screens/Authentication/onboarding_screen.dart';
import 'package:halalapp/screens/Authentication/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halalapp/screens/MainPages/get_user_permission.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes: {
        // "/login": (context) => AuthScreen(),
        "/home": (context) => EnterApp(),
        // "/signup": (context) => signUpPage(
        //       showLoginPage: () {},
        //     ),
        // "/onboarding": (context) => OnboardingScreen(),
      },
    );
  }
}
