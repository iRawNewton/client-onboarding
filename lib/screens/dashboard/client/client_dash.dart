import 'package:flutter/material.dart';

class MyClientDashboard extends StatefulWidget {
  const MyClientDashboard({super.key});

  @override
  State<MyClientDashboard> createState() => _MyClientDashboardState();
}

class _MyClientDashboardState extends State<MyClientDashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffbee6ce),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Column(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Text(
                    'Welcome Demo Name,',
                    style: TextStyle(
                        fontFamily: 'Lato-Regular',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Project Title *******',
                  style: TextStyle(
                      fontFamily: 'Lato-Regular',
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
