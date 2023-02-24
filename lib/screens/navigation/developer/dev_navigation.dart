import 'package:client_onboarding_app/screens/assignproject/developer/assigntask.dart';
import 'package:client_onboarding_app/screens/daily_task/developer/daily_task.dart';
import 'package:client_onboarding_app/screens/dashboard/developer/dev_dash.dart';
import 'package:client_onboarding_app/screens/settings/developer/settings.dart';

import 'package:flutter/material.dart';

class MyDevNav extends StatefulWidget {
  const MyDevNav({super.key});

  @override
  State<MyDevNav> createState() => _MyDevNavState();
}

class _MyDevNavState extends State<MyDevNav> {
  // default index
  int index = 0;
  // screen lists
  final screens = [
    const MyDevDashboard(),
    const MyDevDailyTask(),
    const MyDevTaskAssign(),
    const MyDevSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 12),
          ),
        ),
        child: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
            height: 60.0,
            backgroundColor: Colors.grey.shade300,
            // to hide labels
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            animationDuration: const Duration(seconds: 3),
            destinations: const [
              // home
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              // daily task
              NavigationDestination(
                icon: Icon(Icons.assignment),
                selectedIcon: Icon(Icons.assignment),
                label: 'Daily Task',
              ),
              // task assigned
              NavigationDestination(
                icon: Icon(Icons.assignment_add),
                selectedIcon: Icon(Icons.assignment_add),
                label: 'Task Assigned',
              ),
              // settings
              NavigationDestination(
                icon: Icon(Icons.settings),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ]),
      ),
    );
  }
}
