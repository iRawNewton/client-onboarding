import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class MyDevDashboard extends StatefulWidget {
  const MyDevDashboard({super.key});

  @override
  State<MyDevDashboard> createState() => _MyDevDashboardState();
}

class _MyDevDashboardState extends State<MyDevDashboard> {
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double progressValue = 0;
  bool isVisibleButton = true;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Demo Name',
                    style: TextStyle(
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
                  onChanged: (double value) {
                    setState(() {
                      progressValue = value;
                    });
                  },
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Modify'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
