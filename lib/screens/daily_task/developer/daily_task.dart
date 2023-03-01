import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDevDailyTask extends StatefulWidget {
  const MyDevDailyTask({super.key});

  @override
  State<MyDevDailyTask> createState() => _MyDevDailyTaskState();
}

class _MyDevDailyTaskState extends State<MyDevDailyTask> {
  var maxlengthline = 10;
  var url = 'http://10.0.2.2:80/FlutterApi/updatetask/getDailytask.php';

  dynamic data;

  postData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? developerID = prefs.getString('devId');
    String devID = developerID.toString();
    var response = await http.post(Uri.parse(url), body: {
      'dev_id': devID,
    });
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Your Project List',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder(
                  future: postData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  const SizedBox(height: 15.0),
                                  ListTile(
                                    textColor: Colors.white,
                                    tileColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    leading: Text('${data[index]['cli_date']}'),
                                    title: Text(data[index]['proj_name']),
                                    subtitle: Text(
                                      data[index]['cli_task'],
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                    ),
                                    trailing:
                                        Text('${data[index]['cli_progress']}%'),

                                    // trailing: IconButton(
                                    //     onPressed: () {
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) => AlertDialog(
                                    //                 title: const Text(
                                    //                     'Overall Project Description'),
                                    //                 content: Column(
                                    //                   children: [
                                    //                     Align(
                                    //                       alignment:
                                    //                           Alignment.centerLeft,
                                    //                       child: Text(
                                    //                         'Project Description: ${data[index]['proj_desc']}',
                                    //                         textAlign:
                                    //                             TextAlign.justify,
                                    //                       ),
                                    //                     ),
                                    //                     const SizedBox(
                                    //                         height: 20.0),
                                    //                     Align(
                                    //                       alignment:
                                    //                           Alignment.centerLeft,
                                    //                       child: Text(
                                    //                         'Starting Date: ${data[index]['proj_startdate']}',
                                    //                         textAlign:
                                    //                             TextAlign.justify,
                                    //                       ),
                                    //                     ),
                                    //                     const SizedBox(
                                    //                         height: 10.0),
                                    //                     Align(
                                    //                       alignment:
                                    //                           Alignment.centerLeft,
                                    //                       child: Text(
                                    //                         'Ending Date: ${data[index]['proj_enddate']}',
                                    //                         textAlign:
                                    //                             TextAlign.justify,
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //                 actions: [
                                    //                   TextButton(
                                    //                     style: TextButton.styleFrom(
                                    //                       textStyle:
                                    //                           Theme.of(context)
                                    //                               .textTheme
                                    //                               .labelLarge,
                                    //                     ),
                                    //                     child:
                                    //                         const Text('Continue'),
                                    //                     onPressed: () {
                                    //                       Navigator.of(context)
                                    //                           .pop();
                                    //                     },
                                    //                   ),
                                    //                 ],
                                    //               ));
                                    //     },
                                    //     icon: const Icon(Icons.arrow_forward_ios)),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
