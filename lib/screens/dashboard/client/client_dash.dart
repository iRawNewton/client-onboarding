import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Row(
                    children: const [
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontFamily: 'Lato-Regular',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Demo Name,',
                        style: TextStyle(
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Onboarding Mobile App',
                  style: TextStyle(
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
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image.network(
                  'https://kyptronix.us/images/webp/logo.webp',
                ),
              ),
              // progress bar
              const StepProgressIndicator(
                totalSteps: 100,
                currentStep: 50,
                size: 50,
                padding: 0,
                selectedColor: Colors.green,
                unselectedColor: Colors.red,
                roundedEdges: Radius.circular(10),
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.green],
                ),
                unselectedGradientColor: LinearGradient(
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
