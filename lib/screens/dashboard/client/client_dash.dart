import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

import '../../2selectuser/homescreen.dart';

class MyClientDashboard extends StatefulWidget {
  const MyClientDashboard({super.key});

  @override
  State<MyClientDashboard> createState() => _MyClientDashboardState();
}

class _MyClientDashboardState extends State<MyClientDashboard> {
  // List projectDetails = [];
  var clientName = '';
  var projName = '';
  int progress = 0;
  var iprogress = '';
  dynamic data;

  Future getProjID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? clientID = prefs.getString('cliId');
    String cliID = clientID.toString();
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/dashboard/clientDashboard.php'),
        body: {
          'proj_cli_id': cliID,
        });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      setState(() {
        var name = prefs.getString('cliname');
        clientName = name!;
        projName = data[0]['proj_name'];
        iprogress = data[0]['proj_progress'];
        progress = int.parse(iprogress);

        // print(int.parse(progress));
        // projectDetails = jsonData;
      });
    } else {}
  }

  @override
  void initState() {
    getProjID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("cliId", '');
                    prefs.setString("cliname", '');
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                            fontFamily: 'Lato-Regular',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '$clientName,',
                        style: const TextStyle(
                            fontFamily: 'Pacifico-Regular',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Project title:',
                  style: TextStyle(
                      fontFamily: 'Lato-Regular',
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  projName,
                  style: const TextStyle(
                    fontFamily: 'BakbakOne',
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: const Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              // project logo
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Image.network(
                  'https://kyptronix.us/images/webp/logo.webp',
                ),
              ),
              // progress bar
              StepProgressIndicator(
                totalSteps: 100,
                currentStep: progress,
                size: 50,
                padding: 0,
                // selectedColor: Colors.greenAccent,
                // unselectedColor: Colors.red,
                roundedEdges: const Radius.circular(10),
                selectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.greenAccent],
                ),
                unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.grey, Colors.grey],
                ),
              ),
              const Text('Project progress so far...')
            ],
          ),
        ),
      ),
    );
  }
}
