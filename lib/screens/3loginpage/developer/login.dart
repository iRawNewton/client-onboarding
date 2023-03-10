import 'dart:async';
import 'dart:convert';
import 'package:client_onboarding_app/screens/navigation/developer/dev_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/login/devLogin.php'),
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
        // shared prefs
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("devId", data[0]['id']);
        pref.setString("devname", data[0]['cli_username']);
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
    emailController.dispose();
    passwordController.dispose();
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
                  child: Lottie.asset('assets/animations/dev.json'),
                ),
                // Welcome
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Welcome Developer',
                    style: TextStyle(
                        fontFamily: 'fontOne',
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
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
                        color: Color(0xffFDA615)),
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
                        controller: emailController,
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                // forgot password
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const Text('Forgot Password?'),
                //   ),
                // ),
                // login
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: 50,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        devLoginFunc(
                            emailController, passwordController, context);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffFDA615))),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'fontFive',
                        ),
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
