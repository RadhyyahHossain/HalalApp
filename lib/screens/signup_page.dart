import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/components/my_textfield.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/home_page.dart';
import 'package:halalapp/screens/login_page.dart';

import '../components/my_button.dart';

class signUpPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const signUpPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  //controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void signUpUser(BuildContext context) async {
    try {
      await
          //FirebaseAuth.instance.signInWithEmailAndPassword(
          //     email: emailController.text, password: passwordController.text);
          FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      print("--$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //behavior: SnackBarBehavior.floating,
          content: Text(
              "Oops! There's something wrong with your email or password. Check again!"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUp() {}

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
                  "Sign up",
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
                    controller: _emailController,
                    hintText: "Email",
                    obscureText: false),

                SizedBox(height: 20),

                //password

                MyTextField(
                    controller: _passwordController,
                    hintText: "Password",
                    obscureText: true),

                SizedBox(height: 20),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),

                SizedBox(height: 30),

                //sign up
                MyButton(
                  buttonText: "Sign Up",
                  onTap: signUp,
                  //() => {
                  //signUpUser(context),
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => HomeMainPage()),
                  //),
                  //},
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: widget.showLoginPage,
                      //() {
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => LoginPage()),
                      //);
                      //},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
