import 'dart:convert';

import 'package:client_onboarding_app/screens/2selectuser/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
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
  TextEditingController taskDone = TextEditingController();
  TextEditingController projectID = TextEditingController();
  TextEditingController progressIndicator = TextEditingController();

  DateTime selectedDate = DateTime.now();
  double progressValue = 0;
  bool isVisibleButton = true;
  String devName = '';
  String devID = '';
  List projectList = [];

  void datePickerFunction(dateController) {
    var initialDate = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    dateController.text = formatter.format(initialDate);
  }

  Future getDevName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? developerID = prefs.getString('devId');
    var developerName = prefs.getString('devname');
    setState(() {
      devName = developerName!;
      devID = developerID.toString();
    });
  }

  dynamic data;

  Future getProjID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? developerID = prefs.getString('devId');
    String devID = developerID.toString();
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/getProjectNames.php'),
        body: {
          'proj_dev_id': devID,
        });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        projectList = jsonData;
      });
    } else {}
  }

  @override
  void initState() {
    getProjID();
    getDevName();
    super.initState();
  }

  String? dropdownvalue1;

  // *****************************
  postData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/updatetask/dailytask.php'),
        body: {
          'cli_date': dateController.text,
          'cli_task': taskDone.text,
          'cli_progress': progressIndicator.text,
          'cli_devid': devID,
          'cli_projid': projectID.text
        });

    if (response.statusCode == 200) {
      dateController.clear();
      taskDone.clear();
      progressIndicator.clear();
      projectID.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Success!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }
  // *****************************

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        fontFamily: 'fontOne',
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
                        fontFamily: 'fontOne',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),
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
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        controller: dateController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Working Date',
                        ),
                        onTap: () {
                          datePickerFunction(dateController);
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: taskDone,
                        maxLines: 5,
                        decoration: const InputDecoration(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: DropdownButton(
                      isExpanded: true,
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
                  ),
                ),

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
                  // selectedColor: Colors.greenAccent.shade700,
                  // unselectedColor: Colors.red,
                  roundedEdges: const Radius.circular(10),
                  selectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.greenAccent.shade700, Colors.green],
                  ),
                  unselectedGradientColor: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.grey.shade300, Colors.grey.shade300],
                  ),
                ),
                // *************
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 60,
                  child: LiquidLinearProgressIndicator(
                    value: progressValue.toDouble() / 100, // Defaults to 0.5.
                    valueColor: const AlwaysStoppedAnimation(Colors.blue),
                    backgroundColor: Colors
                        .white, // Defaults to the current Theme's backgroundColor.
                    borderColor: Colors.white,
                    borderWidth: 1.0,
                    borderRadius: 12.0,
                    direction: Axis
                        .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                    center: Text(progressValue.toString()),
                  ),
                ),
                // *************
                // slider
                Slider(
                  activeColor: const Color(0xffFDA615),
                  value: progressValue,
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  onChanged: (double value) {
                    setState(() {
                      progressValue = value;
                      progressIndicator.text = progressValue.toString();
                    });
                  },
                  label: progressValue.toInt().toString(),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      postData(context);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xffFDA615))),
                    child: const Text(
                      'Modify',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
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
