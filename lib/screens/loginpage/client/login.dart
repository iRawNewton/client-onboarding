import 'package:client_onboarding_app/screens/navigation/client/client_navigation.dart';
import 'package:flutter/material.dart';
import '../../signup/developer/signup.dart';

class MyClientLogin extends StatefulWidget {
  const MyClientLogin({super.key});

  @override
  State<MyClientLogin> createState() => _MyClientLoginState();
}

//1 bee6ce
//2 bcffdb
//3 8dffcd
//4 68d89b
//5 4f9d69
class _MyClientLoginState extends State<MyClientLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffbee6ce),
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: TextField(
                        // controller: _email,
                        decoration: InputDecoration(
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
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: TextField(
                        // controller: _email,
                        decoration: InputDecoration(
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
                // forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const MySignUp(),
                      //   ),
                      // );
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.green.shade900),
                    ),
                  ),
                ),

                // login button
                SizedBox(
                  // width: MediaQuery.of(context).size.width * 0.75,
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      // MyDevDashboard
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyClientNav(),
                        ),
                      );
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
