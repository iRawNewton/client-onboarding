import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPmAssignTask extends StatefulWidget {
  const MyPmAssignTask({super.key});

  @override
  State<MyPmAssignTask> createState() => _MyPmAssignTaskState();
}

class _MyPmAssignTaskState extends State<MyPmAssignTask> {
  var maxlengthline = 10;
  var url = 'http://10.0.2.2:80/FlutterApi/post.php';

  final cliId_ = TextEditingController();
  final cliPass = TextEditingController();
  final cliName = TextEditingController();
  final cliEmail = TextEditingController();
  final cliPhone = TextEditingController();
  final cliProjectName = TextEditingController();
  final cliProjectDesc = TextEditingController();
  dynamic data;

  Future<void> postOrderDetails() async {
    // var body = jsonEncode({
    //   'cli_id': cliId.text.trim(),
    //   'cli_pass': cliPass.text.trim(),
    //   'cli_name': cliName.text.trim(),
    //   'cli_email': cliEmail.text.trim(),
    //   'cli_phone': cliPhone.text.trim(),
    //   'cli_project_name': cliProjectName.text.trim(),
    //   'cli_project_desc': cliProjectDesc.text.trim()
    // });

    // var body_ = jsonEncode(
    //     {'cli_id': cliId.text.trim(), 'cli_pass': cliPass.text.trim()});

    final Map<String, dynamic> postdata = {'cli_id': 1001};

    final response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/post.php'),
        body: jsonEncode(postdata));
    if (response.statusCode == 200) {
      print('successfull');
      print(response.statusCode);
      // data = jsonDecode(response.body.toString());
    }
  }

  // ***************************************
  TextEditingController cliId = TextEditingController();
  String _response = '';

  Future<void> _sendRequest() async {
    String url = 'http://10.0.2.2:80/FlutterApi/post.php';
    // String body = cliId.text;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var statusUpdate = {
      'cli_id': '1002',
    };
    String jsonStr = jsonEncode(statusUpdate);

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonStr,
    );
    setState(() {
      _response = response.body;
    });
    print(response.statusCode);
  }
  // ***************************************

  @override
  void dispose() {
    cliId.dispose();
    cliPass.dispose();
    cliName.dispose();
    cliEmail.dispose();
    cliPhone.dispose();
    cliProjectName.dispose();
    cliProjectDesc.dispose();
    super.dispose();
  }

// cli_id	cli_pass	cli_name	cli_email	cli_phone	cli_project_name	cli_project_desc

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              // client ID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      maxLength: maxlengthline,
                      controller: cliId,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'ID',
                        counterText: '',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliPass,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client Pass',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client name',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliEmail,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client Email ID',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliPhone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client Phone Number',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliProjectName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client Project Name',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: cliProjectDesc,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'client Project Description',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  _sendRequest();
                },
                child: const Text('save data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
