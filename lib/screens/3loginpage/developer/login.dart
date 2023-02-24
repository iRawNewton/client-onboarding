import 'dart:async';
import 'dart:convert';
import 'package:client_onboarding_app/screens/navigation/developer/dev_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDevLogin extends StatefulWidget {
  const MyDevLogin({super.key});

  @override
  State<MyDevLogin> createState() => _MyDevLoginState();
}

class _MyDevLoginState extends State<MyDevLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  devLoginFunc(emailText, passwordText, context) async {
    Map<String, String> bodyParameter = {
      'cli_username': emailController.text,
      'cli_password': passwordController.text,
    };
    var response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/login/devLogin.php'),
        body: bodyParameter);

    if (response.body == 'Found Nothing') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    } else {
      List data = jsonDecode(response.body);
      if (data[0]['cli_username'] == emailController.text &&
          data[0]['cli_password'] == passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.green,
            content: Text('Success!'),
          ),
        );
        Timer(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyDevNav(),
            ),
          );
        });
        emailController.clear();
        passwordController.clear();
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
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
                    'Welcome Developer',
                    style: TextStyle(
                        fontFamily: 'BakbakOne',
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // title
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please Login',
                    style: TextStyle(
                        fontFamily: 'BakbakOne',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
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
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
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
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                // forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
                // login button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      devLoginFunc(
                          emailController, passwordController, context);
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
