import 'dart:convert';

import 'package:client_onboarding_app/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDevNewUser extends StatefulWidget {
  const MyDevNewUser({super.key});

  @override
  State<MyDevNewUser> createState() => _MyDevNewUserState();
}

class _MyDevNewUserState extends State<MyDevNewUser> {
  final username = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final designation = TextEditingController();
  final searchValue = TextEditingController();
  dynamic data;
  bool isVisible = true;

  postData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/dev/createdev.php'),
        body: {
          'cli_username': username.text,
          'cli_password': password.text,
          'cli_name': fullname.text,
          'cli_phone': phone.text,
          'cli_email': email.text,
          'cli_designation': designation.text,
        });

    if (response.statusCode == 200) {
      username.clear();
      password.clear();
      fullname.clear();
      phone.clear();
      email.clear();
      designation.clear();

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
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/dev/searchdev.php'),
        body: {
          'searchValue': searchValue.text,
        });

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      searchValue.text = data[0]['id'].toString();
      username.text = data[0]['cli_username'].toString();
      password.text = data[0]['cli_password'].toString();
      fullname.text = data[0]['cli_name'].toString();
      phone.text = data[0]['cli_phone'].toString();
      email.text = data[0]['cli_email'].toString();
      designation.text = data[0]['cli_designation'].toString();
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
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/dev/updatedev.php'),
        body: {
          'searchValue': searchValue.text,
          'cli_username': username.text,
          'cli_password': password.text,
          'cli_name': fullname.text,
          'cli_phone': phone.text,
          'cli_email': email.text,
          'cli_designation': designation.text,
        });

    if (response.statusCode == 200) {
      username.clear();
      password.clear();
      fullname.clear();
      phone.clear();
      email.clear();
      designation.clear();

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

  deleteData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/dev/deletedev.php'),
        body: {
          'searchValue': searchValue.text,
        });

    if (response.statusCode == 200) {
      searchValue.clear();
      username.clear();
      password.clear();
      fullname.clear();
      phone.clear();
      email.clear();
      designation.clear();

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kyptronix Development Team'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
                          setState(() {
                            isVisible = true;
                          });

                          username.clear();
                          password.clear();
                          fullname.clear();
                          phone.clear();
                          email.clear();
                          designation.clear();
                        },
                        icon: const Icon(Icons.cancel))),
                // username
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
                        keyboardType: TextInputType.emailAddress,
                        controller: username,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                ),
                // password
                const SizedBox(height: 15),
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
                        keyboardType: TextInputType.text,
                        controller: password,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                // name
                const SizedBox(height: 15),
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
                        keyboardType: TextInputType.name,
                        controller: fullname,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                        ),
                      ),
                    ),
                  ),
                ),
                // phone
                const SizedBox(height: 15),
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
                        keyboardType: TextInputType.number,
                        controller: phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                        ),
                      ),
                    ),
                  ),
                ),
                // email
                const SizedBox(height: 15),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email ID',
                        ),
                      ),
                    ),
                  ),
                ),
                // designation
                const SizedBox(height: 15),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: designation,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Designation',
                        ),
                      ),
                    ),
                  ),
                ),
                // elevatedbutton
                const SizedBox(height: 50),
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
                                updateData(context);
                                setState(() {
                                  isVisible = true;
                                });
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
                        'Save',
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
