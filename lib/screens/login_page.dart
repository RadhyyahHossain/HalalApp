import 'package:flutter/material.dart';
import 'package:halalapp/components/my_textfield.dart';
import 'package:halalapp/constants.dart';

import '../components/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  //controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello
                Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Find halal food near you!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 45),
                //email text field
                MyTextField(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),

                SizedBox(height: 20),

                //password

                MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),

                SizedBox(height: 10),

                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                //sign in
                MyButton(
                  buttonText: "Sign In",
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                //google button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
