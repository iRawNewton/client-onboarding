import 'package:flutter/material.dart';
import 'screens/homescreen/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/test/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const MyUsers(),
    );
  }
}
