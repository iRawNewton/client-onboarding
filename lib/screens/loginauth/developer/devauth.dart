import 'package:client_onboarding_app/screens/dashboard/developer/dev_dash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../3loginpage/developer/login_signup.dart';

class MyDevAuthPage extends StatelessWidget {
  const MyDevAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const MyDevDashboard();
          } else {
            return const LoginSignup();
          }
        }),
      ),
    );
  }
}
