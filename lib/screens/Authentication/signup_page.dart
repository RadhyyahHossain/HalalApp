import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halalapp/components/my_textfield.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/home_page.dart';
import 'package:halalapp/screens/Authentication/login_page.dart';

import '../../components/my_button.dart';

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
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();

    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  Future signUpUser(BuildContext context) async {
    //auth
    try {
      if (passwordConfirmed()) {
        await
            //FirebaseAuth.instance.signInWithEmailAndPassword(
            //     email: emailController.text, password: passwordController.text);
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        //add user details
        addUserDetails(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      }
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

  Future addUserDetails(String email, String password) async {
    await FirebaseFirestore.instance.collection("users").add({
      "email": email,
      "password": password,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

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
                  controller: _confirmpasswordController,
                  hintText: "Confirm password",
                  obscureText: true,
                ),

                SizedBox(height: 30),

                //sign up
                MyButton(
                  buttonText: "Sign Up",
                  onTap: () => {signUpUser(context)},
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
                      onTap: widget.showLoginPage,
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
