import 'package:flutter/material.dart';
import 'package:halalapp/screens/Authentication/auth_screen.dart';
import 'package:halalapp/screens/MainPages/MapScreen.dart';
import 'package:halalapp/screens/MainPages/better_detailsPage.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:halalapp/screens/MainPages/map_screen.dart';
import 'package:halalapp/screens/Authentication/onboarding_screen.dart';
import 'package:halalapp/screens/Authentication/signup_page.dart';
import 'package:halalapp/screens/MainPages/screen_router.dart';
import 'package:halalapp/screens/MainPages/userLocation.dart';
import 'screens/Authentication/login_page.dart';
import 'package:halalapp/screens/MainPages/userLocation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';

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
      // home: Scaffold(
      //   body: Center(
      //     child: Image(
      //       image: AssetImage('assets/person.png'),
      //     ),
      //   ),
      // )
      initialRoute: "/home",
      routes: {
        "/login": (context) => AuthScreen(),
        "/home": (context) => ScreenRouter(),
        "/signup": (context) => signUpPage(
              showLoginPage: () {},
            ),
        "/onboarding": (context) => OnboardingScreen(),
      },
    );
  }
}
