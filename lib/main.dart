import 'package:client_onboarding_app/screens/1getstarted/getstarted.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Client Onboarding Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: const MyUsers(),
      home: const MyAppGetStarted(),
    );
  }
}
