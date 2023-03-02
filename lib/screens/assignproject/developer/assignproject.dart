import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyDevProjectDetails extends StatefulWidget {
  const MyDevProjectDetails({super.key});

  @override
  State<MyDevProjectDetails> createState() => _MyDevProjectDetailsState();
}

class _MyDevProjectDetailsState extends State<MyDevProjectDetails> {
  var maxlengthline = 10;
  var url =
      'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/project/ShowDevProjectDetails.php';

  dynamic data;

  postData(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? developerID = prefs.getString('devId');
    String devID = developerID.toString();
    var response = await http.post(Uri.parse(url), body: {
      'proj_dev_id': devID,
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
                  future: postData(context),
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
                                  const SizedBox(height: 10.0),
                                  ListTile(
                                    textColor: Colors.white,
                                    tileColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    iconColor: Colors.white,
                                    // leading: Text('ID:${data[index]['proj_dev_id']}'),
                                    title: Text(data[index]['proj_name']),
                                    subtitle: Text(
                                      data[index]['proj_desc'],
                                      overflow: TextOverflow.fade,
                                      maxLines: 2,
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        'Overall Project Description'),
                                                    content: Column(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Project Description: ${data[index]['proj_desc']}',
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 20.0),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Starting Date: ${data[index]['proj_startdate']}',
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10.0),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Ending Date: ${data[index]['proj_enddate']}',
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                        child: const Text(
                                                            'Continue'),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  ));
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios)),
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
