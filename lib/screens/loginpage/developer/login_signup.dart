import 'package:client_onboarding_app/screens/loginpage/developer/login.dart';
import 'package:client_onboarding_app/screens/signup/developer/signup.dart';
import 'package:flutter/material.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  // initially show login page
  bool showLoginPage = true;
  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return MyLogin(showRegisterPage: toggleScreen);
    } else {
      return MySignUp(showLoginPage: toggleScreen);
    }
  }
}
