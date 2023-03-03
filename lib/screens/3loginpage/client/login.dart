import 'dart:async';
import 'dart:convert';
import 'package:client_onboarding_app/screens/dashboard/client/client_dash.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClientLogin extends StatefulWidget {
  const MyClientLogin({super.key});

  @override
  State<MyClientLogin> createState() => _MyClientLoginState();
}

class _MyClientLoginState extends State<MyClientLogin> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();

  cliLoginFunc(emailText, passwordText, context) async {
    Map<String, String> bodyParameter = {
      'cli_userid': emailText.text,
      'cli_pass': passwordText.text,
    };
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/login/cliLogin.php'),
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
      if (data[0]['cli_userid'] == emailText.text &&
          data[0]['cli_pass'] == passwordText.text) {
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
              builder: (context) => const MyClientDashboard(),
            ),
          );
        });
        emailText.clear();
        passwordText.clear();
        // shared prefs
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("cliId", data[0]['id']);
        pref.setString("cliname", data[0]['cli_name']);
        // snackbar
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
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  child: Lottie.asset('assets/animations/client.json'),
                ),
                // Welcome
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome client',
                    style: TextStyle(
                      fontFamily: 'fontOne',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // title
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Login to continue',
                    style: TextStyle(
                      fontFamily: 'fontOne',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                const SizedBox(height: 60.0),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
                        controller: emailText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
                        controller: passwordText,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.deepOrange,
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
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      cliLoginFunc(emailText, passwordText, context);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepOrange)),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'fontFive',
                      ),
                    ),
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
