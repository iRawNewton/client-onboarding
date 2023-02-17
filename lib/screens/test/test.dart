import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

class MyTestScreen extends StatefulWidget {
  const MyTestScreen({super.key});

  @override
  State<MyTestScreen> createState() => _MyTestScreenState();
}

class _MyTestScreenState extends State<MyTestScreen> {
  // void sqlDb() async {
  //   // Open a connection (testdb should already exist)
  //   var conn = await MySqlConnection.connect(
  //     ConnectionSettings(
  //         host: 'localhost',
  //         port: 80,
  //         user: 'root',
  //         password: '',
  //         db: 'clientonboarding'),
  //   );

  //   // Query the database using a parameterized query
  //   var results = await conn.query('SELECT * FROM delivery');
  //   if (conn == true) {
  //     print('object');
  //   }
  //   print('$results');
  // }

  Future getData() async {
    var url = '';
    http.Response response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);
    print(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          onPressed: () {
            getData();
          },
          child: const Text('click me'),
        ),
      ),
    );
  }
}
