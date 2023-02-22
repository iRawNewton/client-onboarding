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

  // id	proj_name	proj_desc	proj_startdate	proj_enddate	proj_cli_id	proj_dev_id
  postData(context) async {
    print(dateControllerStart.text);
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
  //

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
              // project cli id
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
                      controller: projectClientID,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Project Client ID',
                      ),
                    ),
                  ),
                ),
              ),
              // project cli dev id
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
                      controller: projectDevId,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Project Dev ID',
                      ),
                    ),
                  ),
                ),
              ),
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
