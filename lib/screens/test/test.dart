// import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mysql1/mysql1.dart';
// import 'package:http/http.dart' as http;

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  var txt = 'click';
  var port = 3306;
  Future sqlDb() async {
    // Open a connection (testdb should already exist)
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
          host: 'localhost',
          port: port,
          user: 'id20319221_root',
          password: 'zeQ[~uX5TXK-p@*B',
          db: 'id20319221_demodatabase'),
    );
    // Query the database using a parameterized query
    var results = await conn.query('select count(*) from client');

    for (var row in results) {
      if (row[0] == 1) {
        // print(results);
        // --------------

        // // shared prefs
        // final SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString('email', emailController.text);
        // // shared prefs
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const MyNavigation()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            sqlDb();
          },
          child: Text(txt),
        ),
      ),
    );
  }
}
