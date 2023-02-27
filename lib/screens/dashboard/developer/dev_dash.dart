import 'dart:convert';

import 'package:client_onboarding_app/screens/2selectuser/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:http/http.dart' as http;

class MyDevDashboard extends StatefulWidget {
  const MyDevDashboard({super.key});

  @override
  State<MyDevDashboard> createState() => _MyDevDashboardState();
}

class _MyDevDashboardState extends State<MyDevDashboard> {
  // delete shared prefs
  Future deleteSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('devId');
  }

  TextEditingController dateController = TextEditingController();
  TextEditingController projectID = TextEditingController();

  DateTime selectedDate = DateTime.now();
  double progressValue = 0;
  bool isVisibleButton = true;
  String devName = '';
  List projectList = [];

  void selectDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        selectedDate = value!;
      });
    });
  }

  Future getDevName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var developerName = prefs.getString('devname');
    setState(() {
      devName = developerName!;
    });
  }

  // project ID
  Future getProjID() async {
    var baseUrl = "http://10.0.2.2:80/FlutterApi/project/getProjectNames.php";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        projectList = jsonData;
      });
    }
  }

  @override
  void initState() {
    getProjID();
    getDevName();
    super.initState();
  }

  String? dropdownvalue1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
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
                prefs.setString("devId", '');
                prefs.setString("devname", '');
              },
              icon: const Icon(Icons.logout),
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // hi
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hi,',
                    style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // user name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    devName,
                    style: const TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50),
                // date
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
                        keyboardType: TextInputType.none,
                        controller: dateController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        ),
                        onTap: () {
                          selectDate();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // tasks done
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
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Task Done',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Select project ID
                // project cli ID
                DropdownButton(
                  hint: const Text('Project Title'),
                  items: projectList.map((item) {
                    return DropdownMenuItem(
                      value: item['id'].toString(),
                      child: Text(item['proj_name'].toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      dropdownvalue1 = newVal;
                      projectID.text = newVal!;
                    });
                  },
                  value: dropdownvalue1,
                ),
// *********************************************************
                const SizedBox(height: 20),
                // progress indicator1
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Progress Indicator',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 2),
                StepProgressIndicator(
                  totalSteps: 100,
                  currentStep: progressValue.toInt(),
                  size: 50,
                  padding: 0,
                  selectedColor: Colors.green,
                  unselectedColor: Colors.red,
                  roundedEdges: const Radius.circular(10),
                  selectedGradientColor: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.green, Colors.green],
                  ),
                  unselectedGradientColor: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey, Colors.grey],
                  ),
                ),
                // slider
                Slider(
                  value: progressValue,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double value) {
                    setState(() {
                      progressValue = value;
                    });
                  },
                  label: progressValue.toInt().toString(),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Modify'),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
