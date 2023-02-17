import 'package:client_onboarding_app/screens/loginauth/developer/devauth.dart';
import 'package:client_onboarding_app/screens/loginpage/client/login.dart';
import 'package:client_onboarding_app/screens/loginpage/developer/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyUsers extends StatefulWidget {
  const MyUsers({super.key});

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_1pxqjqps.json'),
                ),

                // Project Manager
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/images/manager.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'Project\nManager',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Client
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyClientLogin(),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/images/client.png'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'Client',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Developer
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyDevAuthPage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/coding.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              'Developer',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
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
