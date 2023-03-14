import 'dart:convert';

import 'package:client_onboarding_app/screens/widgets/widgets.dart';
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
  final searchValue = TextEditingController();
  bool isVisible = true;
  dynamic data;

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
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/createProject.php'),
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

  searchData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/searchProject.php'),
        body: {
          'searchValue': searchValue.text,
        });
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      searchValue.text = data[0]['id'].toString();
      projectName.text = data[0]['proj_name'].toString();
      projectDesc.text = data[0]['proj_desc'].toString();
      dateControllerStart.text = data[0]['proj_startdate'].toString();
      dateControllerEnd.text = data[0]['proj_enddate'].toString();
      setState(() {
        dropdownvalue1 = data[0]['proj_cli_id'].toString();
        projectDevId.text = data[0]['proj_cli_id'].toString();
        dropdownvalue2 = data[0]['proj_dev_id'].toString();
        projectClientID.text = data[0]['proj_dev_id'].toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }

  updateData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/updateProject.php'),
        body: {
          'searchValue': searchValue.text,
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

  deleteData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/deleteProject.php'),
        body: {
          'searchValue': searchValue.text,
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
    var baseUrl =
        'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/ListBox1.php';
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
    var baseUrl =
        'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/ListBox2.php';
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
          title: const Text('Kyptronix Projects'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchValue,
                          decoration: const InputDecoration(hintText: 'Search'),
                        ),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {
                            searchData(context);
                            setState(() {
                              isVisible = false;
                            });
                          },
                          icon: const Icon(Icons.search),
                          label: const Text('Search'))
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Divider(),
                // const SizedBox(height: 10.0),
                Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          projectName.clear();
                          projectDesc.clear();
                          dateControllerStart.clear();
                          dateControllerEnd.clear();
                        },
                        icon: const Icon(Icons.cancel))),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
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
                const SizedBox(height: 10),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
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
                const SizedBox(height: 10),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
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
                const SizedBox(height: 10),
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
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'fontThree'),
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
                const SizedBox(height: 10),
                // project cli ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      dropdownColor: Colors.grey[200],
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'fontThree',
                          color: Colors.black),
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text('Client Name'),
                      items: clientList.map((item) {
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
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // project dev ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      dropdownColor: Colors.grey[200],
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'fontThree',
                          color: Colors.black),
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: const Text('Developer Name'),
                      items: devList.map((item) {
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
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        'Please tap once in both the client and developer field')),
                // ***********
                const SizedBox(height: 40),
                Visibility(
                  visible: false,
                  replacement: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                updateData(context);
                                setState(() {
                                  isVisible = true;
                                });
                              },
                              icon: const Icon(
                                Icons.update,
                                // color: Colors.white,
                              ),
                              // style: const ButtonStyle(
                              //     backgroundColor: MaterialStatePropertyAll(
                              //         Color(0xff0101D3))),
                              label: const Text(
                                'Update',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'fontTwo',
                                ),
                              ))),
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.44,
                          child: ElevatedButton.icon(
                              onPressed: () {
                                deleteData(context);
                                setState(() {
                                  isVisible = true;
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                // color: Colors.white,
                              ),
                              // style: const ButtonStyle(
                              //     backgroundColor: MaterialStatePropertyAll(
                              //         Color(0xff0101D3))),
                              label: const Text(
                                'Delete',
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'fontTwo',
                                ),
                              ))),
                    ],
                  ),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      onPressed: () {
                        postData(context);
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xff0101D3))),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'fontTwo',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const MyDrawerInfo(),
      ),
    );
  }
}
