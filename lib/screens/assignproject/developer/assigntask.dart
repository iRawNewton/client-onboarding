import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyDevTaskAssign extends StatefulWidget {
  const MyDevTaskAssign({super.key});

  @override
  State<MyDevTaskAssign> createState() => _MyDevTaskAssignState();
}

class _MyDevTaskAssignState extends State<MyDevTaskAssign> {
  dynamic data;
  Future<void> getOrderDetails() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:80/FlutterApi/get.php'),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Task Assigned',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              FutureBuilder(
                future: getOrderDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((BuildContext context, int index) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text(data[index]['cli_id']),
                                title: Text(data[index]['cli_name'].toString()),
                                trailing:
                                    Text(data[index]['cli_email'].toString()),
                              ),
                              // Text(data[index]['name'].toString()),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
