import 'dart:async';
import 'dart:convert';
import 'package:client_onboarding_app/screens/navigation/pm/pm_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPmLogin extends StatefulWidget {
  const MyPmLogin({super.key});

  @override
  State<MyPmLogin> createState() => _MyPmLoginState();
}

class _MyPmLoginState extends State<MyPmLogin> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  pmLoginFunc(emailText, passwordText, context) async {
    Map<String, String> bodyParameter = {
      'cli_username': emailText.text,
      'cli_password': passwordText.text,
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/login/pmLogin.php'),
        body: bodyParameter);

    if (response.body == 'No user found') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Incorrect Username or Password. Try again!'),
        ),
      );
    } else {
      List data = jsonDecode(response.body);
      if (data[0]['cli_username'] == emailText.text &&
          data[0]['cli_password'] == passwordText.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text('Login Successful!'),
          ),
        );
        Timer(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyPmNavigation(),
            ),
          );
        });
        emailText.clear();
        passwordText.clear();
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
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber.shade100,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                // Welcome
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                      fontFamily: 'BakbakOne',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Client Onboarding Mobile \nApplication',
                    style: TextStyle(
                      fontFamily: 'BakbakOne',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4f9d69),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                        controller: emailText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0xff4f9d69),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // password
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
                        controller: passwordText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xff4f9d69),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // login button
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.75,
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      pmLoginFunc(emailText, passwordText, context);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
