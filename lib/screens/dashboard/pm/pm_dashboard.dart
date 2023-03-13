import 'dart:convert';

import 'package:client_onboarding_app/screens/assignproject/pm/assign_project.dart';
import 'package:client_onboarding_app/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../2selectuser/homescreen.dart';
import 'package:http/http.dart' as http;

class MyPmDashboard extends StatefulWidget {
  const MyPmDashboard({super.key});

  @override
  State<MyPmDashboard> createState() => _MyPmDashboardState();
}

class _MyPmDashboardState extends State<MyPmDashboard> {
  String pmId = '';
  String pmName = '';
  bool isVisible = true;

  Future getPmName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pmID = prefs.getString('pmId');
    var pmNAME = prefs.getString('pmname');
    setState(() {
      pmId = pmID.toString();
      pmName = pmNAME!;
    });
  }

  var url =
      'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/getEntireProjectList.php';

  dynamic data;

  Future<void> getProjectList() async {
    var response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      setState(() {
        isVisible = !isVisible;
      });
    } else {
      setState(() {
        isVisible = true;
      });
    }
  }

  @override
  void initState() {
    getPmName();
    // getProjectList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const MyUsers();
                    },
                  ),
                );
                // deleteSharedPrefs();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("pmId", '');
                prefs.setString("pmname", '');
              },
              icon: const Icon(Icons.logout),
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome,',
                  style: TextStyle(
                      fontFamily: 'fontOne',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  pmName,
                  style: const TextStyle(
                      fontFamily: 'fontOne',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              FutureBuilder(
                  future: getProjectList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (data == null) {
                      return SizedBox(
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                                'assets/animations/not_found.json'),
                            const Text(
                              'Uhh Oh! No project found',
                              style: TextStyle(
                                  fontFamily: 'fontTwo',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 40.0),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyProjectDetails(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Create a new project',
                                    style: TextStyle(
                                        fontFamily: 'fontThree', fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            data[index]['proj_name'],
                                            style: const TextStyle(
                                                fontFamily: 'fontTwo',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        CircularStepProgressIndicator(
                                          totalSteps: 100,
                                          currentStep: data[index]
                                              ['proj_progress'],
                                          stepSize: 15,
                                          selectedColor: Colors.green,
                                          unselectedColor: Colors.black,
                                          padding: 0,
                                          width: 100,
                                          height: 100,
                                          selectedStepSize: 15,
                                          roundedCap: (_, __) => false,
                                          child: Center(
                                              child: Text(
                                            '${data[index]['proj_progress']} %',
                                            style: const TextStyle(
                                                fontFamily: 'fontOne'),
                                          )),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.green.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                    'Start Date: ${data[index]['proj_startdate']}',
                                                    style: const TextStyle(
                                                      fontFamily: 'fontTwo',
                                                      fontSize: 16,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.pink.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                    'End Date: ${data[index]['proj_enddate']}',
                                                    style: const TextStyle(
                                                      fontFamily: 'fontTwo',
                                                      fontSize: 16,
                                                      color: Colors.pink,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.yellow.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                  'Developer: ${data[index]['cli_name']}',
                                                  style: TextStyle(
                                                    fontFamily: 'fontTwo',
                                                    fontSize: 16,
                                                    color:
                                                        Colors.yellow.shade800,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Text(
                                                  'Client: ${data[index]['dev_name']}',
                                                  style: const TextStyle(
                                                      fontFamily: 'fontTwo',
                                                      fontSize: 16,
                                                      color: Colors.indigo,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {},
            child: const Icon(Icons.chat_bubble_outline)),
        drawer: const MyDrawerInfo());
  }
}
// Text(data[index]['proj_name']);