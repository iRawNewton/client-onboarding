import 'dart:convert';

import 'package:client_onboarding_app/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPmCreateClient extends StatefulWidget {
  const MyPmCreateClient({super.key});

  @override
  State<MyPmCreateClient> createState() => _MyPmCreateClientState();
}

class _MyPmCreateClientState extends State<MyPmCreateClient> {
  var maxlengthline = 10;
  bool isVisible = true;
  final id = TextEditingController();
  final cliId = TextEditingController();
  final cliPass = TextEditingController();
  final cliName = TextEditingController();
  final cliEmail = TextEditingController();
  final cliPhone = TextEditingController();
  final cliDesignation = TextEditingController();
  final searchValue = TextEditingController();
  dynamic data;

  postData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/createClient.php'),
        body: {
          'cli_userid': cliId.text,
          'cli_pass': cliPass.text,
          'cli_name': cliName.text,
          'cli_email': cliEmail.text,
          'cli_phone': cliPhone.text,
          'cli_designation': 'client',
        });
    if (response.statusCode == 200) {
      cliId.clear();
      cliPass.clear();
      cliName.clear();
      cliEmail.clear();
      cliPhone.clear();
      cliDesignation.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Success!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }

  searchData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/searchClient.php'),
        body: {
          'queryvalue': searchValue.text,
          // 'queryvalue': '1',
        });
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      id.text = data[0]['id'].toString();
      cliId.text = data[0]['cli_userid'].toString();
      cliPass.text = data[0]['cli_pass'].toString();
      cliName.text = data[0]['cli_name'].toString();
      cliEmail.text = data[0]['cli_email'].toString();
      cliPhone.text = data[0]['cli_phone'].toString();
      cliDesignation.text = data[0]['cli_designation'].toString();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('No user!'),
        ),
      );
    }
  }

  updateData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/updateClient.php'),
        body: {
          'id': id.text,
          'cli_userid': cliId.text,
          'cli_pass': cliPass.text,
          'cli_name': cliName.text,
          'cli_email': cliEmail.text,
          'cli_phone': cliPhone.text,
        });
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Success!'),
        ),
      );

      cliId.clear();
      cliPass.clear();
      cliName.clear();
      cliEmail.clear();
      cliPhone.clear();
      cliDesignation.clear();
      searchValue.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }

  deleteData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/deleteClient.php'),
        body: {
          'id': id.text,
        });
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Success!'),
        ),
      );

      cliId.clear();
      cliPass.clear();
      cliName.clear();
      cliEmail.clear();
      cliPhone.clear();
      cliDesignation.clear();
      searchValue.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    cliId.dispose();
    cliPass.dispose();
    cliName.dispose();
    cliEmail.dispose();
    cliPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kyptronix Client Account'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchValue,
                          decoration: const InputDecoration(hintText: 'Search'),
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            searchData(context);
                            setState(() {
                              isVisible = false;
                            });
                          },
                          icon: const Icon(Icons.search),
                          label: const Text('Search'))
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(),
                // const SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          cliId.clear();
                          cliPass.clear();
                          cliName.clear();
                          cliEmail.clear();
                          cliPhone.clear();
                          cliDesignation.clear();
                          setState(() {
                            isVisible = true;
                          });
                        },
                        icon: const Icon(Icons.cancel))),
                // client ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          hintText: 'Username',
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          hintText: 'Full Name',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          hintText: 'Email ID',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                          hintText: 'Phone',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: cliDesignation,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Designation',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                Visibility(
                  visible: isVisible,
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  isVisible = true;
                                });
                                updateData(context);

                                // postData(context);
                              },
                              icon: const Icon(
                                Icons.update,
                                // color: Colors.white,
                              ),
                              // style: const ButtonStyle(
                              //     backgroundColor: MaterialStatePropertyAll(
                              //         Color(0xff0101D3))),
                              label: const Text(
                                'Update',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'fontTwo',
                                ),
                              ))),
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                deleteData(context);
                                setState(() {
                                  isVisible = true;
                                });
                                // postData(context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                // color: Colors.white,
                              ),
                              // style: const ButtonStyle(
                              //     backgroundColor: MaterialStatePropertyAll(
                              //         Color(0xff0101D3))),
                              label: const Text(
                                'Delete',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'fontTwo',
                                ),
                              ))),
                    ],
                  ),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      onPressed: () {
                        postData(context);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff0101D3))),
                      child: const Text(
                        'Create client account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'fontTwo',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const MyDrawerInfo(),
      ),
    );
  }
}
