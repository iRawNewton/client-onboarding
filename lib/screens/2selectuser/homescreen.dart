import 'package:client_onboarding_app/screens/3loginpage/developer/login.dart';
import 'package:client_onboarding_app/screens/3loginpage/client/login.dart';
import 'package:client_onboarding_app/screens/3loginpage/pm/login.dart';
import 'package:client_onboarding_app/screens/dashboard/client/client_dash.dart';
import 'package:client_onboarding_app/screens/navigation/developer/dev_navigation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

var checkDevId = '';
var clientID = '';

class MyUsers extends StatefulWidget {
  const MyUsers({super.key});

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  // shared prefs for dev
  Future devValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var developerId = sharedPreferences.getString('devId');
    var clientId = sharedPreferences.getString('cliId');
    setState(() {
      checkDevId = developerId!;
      clientID = clientId!;
    });
  }

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
                const SizedBox(height: 30),
                // logo
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    radius: 70.0,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                // choose your role
                const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Choose Your Role',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins-Regular'),
                    )),
                // project manager
                const SizedBox(height: 5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundColor: const Color(0xff0101D3),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            radius: 70.0,
                            child: Lottie.asset('assets/animations/pm.json'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyPmLogin()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0101D3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0))),
                          child: const Text(
                            'Project Manager',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // client
                const SizedBox(height: 5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundColor: const Color(0xff4BE0DC),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            radius: 70.0,
                            child:
                                Lottie.asset('assets/animations/client.json'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ElevatedButton(
                          onPressed: () {
                            devValidationData().whenComplete(() async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => clientID == ''
                                          ? const MyClientLogin()
                                          : const MyClientDashboard()));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4BE0DC),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0))),
                          child: const Text(
                            'Client',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // developer
                const SizedBox(height: 5),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CircleAvatar(
                          radius: 80.0,
                          backgroundColor: const Color(0xffFDA615),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            radius: 70.0,
                            child: Lottie.asset('assets/animations/dev.json'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ElevatedButton(
                          onPressed: () {
                            devValidationData().whenComplete(() async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => checkDevId == ''
                                          ? const MyDevLogin()
                                          : const MyDevNav()));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFDA615),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0))),
                          child: const Text(
                            'Developer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Project Manager
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => const MyPmLogin()));
                //         },
                //         child: Column(
                //           children: [
                //             CircleAvatar(
                //               radius: 50.0,
                //               backgroundColor: Colors.transparent,
                //               child: Image.asset('assets/images/manager.png'),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(vertical: 10.0),
                //               child: Container(
                //                 width: 100,
                //                 height: 40,
                //                 decoration: const BoxDecoration(
                //                     color: Colors.black,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(10))),
                //                 child: const Center(
                //                   child: Text(
                //                     'Project\nManager',
                //                     style: TextStyle(
                //                         fontFamily: 'Poppins-Regular',
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.white),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       const Spacer(),
                //       // Client
                //       InkWell(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => const MyClientLogin(),
                //             ),
                //           );
                //         },
                //         child: Column(
                //           children: [
                //             CircleAvatar(
                //               radius: 50.0,
                //               backgroundColor: Colors.transparent,
                //               child: Image.asset('assets/images/client.png'),
                //             ),
                //             Padding(
                //               padding:
                //                   const EdgeInsets.symmetric(vertical: 10.0),
                //               child: Container(
                //                 width: 100,
                //                 height: 40,
                //                 decoration: const BoxDecoration(
                //                     color: Colors.black,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(10))),
                //                 child: const Center(
                //                   child: Text(
                //                     'Client',
                //                     style: TextStyle(
                //                         fontFamily: 'Poppins-Regular',
                //                         fontSize: 14,
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.white),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 20),
                // Developer
                // InkWell(
                //   onTap: () {
                //     devValidationData().whenComplete(() async {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => checkDevId == ''
                //                   ? const MyDevLogin()
                //                   : const MyDevNav()));
                //     });
                //   },
                //   child: Column(
                //     children: [
                //       CircleAvatar(
                //         radius: 50.0,
                //         backgroundColor: Colors.transparent,
                //         child: Image.asset('assets/images/coding.png'),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 10.0),
                //         child: Container(
                //           width: 100,
                //           height: 40,
                //           decoration: const BoxDecoration(
                //               color: Colors.black,
                //               borderRadius:
                //                   BorderRadius.all(Radius.circular(10))),
                //           child: const Center(
                //             child: Text(
                //               'Developer',
                //               style: TextStyle(
                //                   fontFamily: 'Poppins-Regular',
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.bold,
                //                   color: Colors.white),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
