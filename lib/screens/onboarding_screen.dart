import 'package:flutter/material.dart';
import 'package:halalapp/components/my_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Spacer(),
          Text("Onboarding"),
          Spacer(),
          MyButton(
            buttonText: "Get Started!",
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
          ),
          Spacer(),
        ],
      ),
    ));
  }
}
