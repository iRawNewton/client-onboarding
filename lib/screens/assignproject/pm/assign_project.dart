import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MyProjectDetails extends StatefulWidget {
  const MyProjectDetails({super.key});

  @override
  State<MyProjectDetails> createState() => _MyProjectDetailsState();
}

class _MyProjectDetailsState extends State<MyProjectDetails> {
  TextEditingController projectName = TextEditingController();
  TextEditingController projectDesc = TextEditingController();
  var dateControllerStart = TextEditingController();
  var dateControllerEnd = TextEditingController();
  TextEditingController projectClientID = TextEditingController();
  TextEditingController projectDevId = TextEditingController();

  DateTime date = DateTime.now();

  List clientList = [];
  List devList = [];

  void datePickerFunction(dateController) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2025),
    ).then(
      (value) {
        setState(() {
          date = value!;
          final formatter = DateFormat('dd/MM/yyyy');
          final formatteddate = formatter.format(date);
          dateController.text = formatteddate;
        });
      },
    );
  }

  postData(context) async {
    var response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/project/createProject.php'),
        body: {
          'proj_name': projectName.text,
          'proj_desc': projectDesc.text,
          'proj_startdate': dateControllerStart.text,
          'proj_enddate': dateControllerEnd.text,
          'proj_cli_id': projectClientID.text,
          'proj_dev_id': projectDevId.text,
        });

    if (response.statusCode == 200) {
      projectName.clear();
      projectDesc.clear();
      dateControllerStart.clear();
      dateControllerEnd.clear();
      projectClientID.clear();
      projectDevId.clear();

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

  // developerID
  Future getClientID() async {
    var baseUrl = "http://10.0.2.2:80/FlutterApi/ListBox1.php";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        clientList = jsonData;
      });
    }
  }

  // clientID
  Future getDevID() async {
    var baseUrl = "http://10.0.2.2:80/FlutterApi/ListBox2.php";
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        devList = jsonData;
      });
    }
  }

  @override
  void initState() {
    getClientID();
    getDevID();
    super.initState();
  }

  String? dropdownvalue1;
  String? dropdownvalue2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Project'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
          child: Column(
            children: [
              // project name
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
                      keyboardType: TextInputType.text,
                      controller: projectName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Project Name',
                      ),
                    ),
                  ),
                ),
              ),

              // project description
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
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      controller: projectDesc,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Project Description',
                      ),
                    ),
                  ),
                ),
              ),
              // project start date
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
                      onTap: () {
                        datePickerFunction(dateControllerStart);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.none,
                      controller: dateControllerStart,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Start date',
                      ),
                    ),
                  ),
                ),
              ),
              // project end date
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
                      onTap: () {
                        datePickerFunction(dateControllerEnd);
                      },
                      maxLines: null,
                      keyboardType: TextInputType.none,
                      controller: dateControllerEnd,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'End date',
                      ),
                    ),
                  ),
                ),
              ),
              // project cli ID
              DropdownButton(
                hint: const Text('Client Name'),
                items: devList.map((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: Text(item['cli_name'].toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    dropdownvalue1 = newVal;
                    projectClientID.text = newVal!;
                  });
                },
                value: dropdownvalue1,
                // controller: projectClientID,
              ),
              // project dev ID
              DropdownButton(
                hint: const Text('Developer Name'),
                items: clientList.map((item) {
                  return DropdownMenuItem(
                    value: item['id'].toString(),
                    child: Text(item['cli_name'].toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    dropdownvalue2 = newVal;
                    projectDevId.text = newVal!;
                  });
                },
                value: dropdownvalue2,
                // controller: projectDevId,
              ),
              // ***********
              const SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.75,
                child: ElevatedButton(
                  onPressed: () {
                    postData(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
