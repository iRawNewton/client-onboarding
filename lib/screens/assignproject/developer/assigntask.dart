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
  TextEditingController devId = TextEditingController();

  devLoginFunc(context) async {
    Map<String, String> bodyParameter = {
      // 'proj_dev_id': devId.text,
      'proj_dev_id': '14',
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/login/devLogin.php'),
        body: bodyParameter);

    if (response.body == 'Found Nothing') {
    } else {
      List data = jsonDecode(response.body);
      if (data[0]['proj_dev_id'] == devId.text) {
        data = jsonDecode(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.yellow,
            content: Text('An error occured. Please report to Dev!'),
          ),
        );
      }
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
                future: devLoginFunc(context),
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
                                leading: Text(data[index]['id']),
                                title:
                                    Text(data[index]['proj_name'].toString()),
                                subtitle:
                                    Text(data[index]['proj_desc'].toString()),
                                trailing: const Icon(Icons.forward),
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
