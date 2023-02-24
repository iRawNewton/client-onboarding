import 'package:client_onboarding_app/screens/assignproject/client/cli_assigntask.dart';
import 'package:client_onboarding_app/screens/daily_task/client/cli_daily_task.dart';
import 'package:client_onboarding_app/screens/dashboard/client/client_dash.dart';
import 'package:client_onboarding_app/screens/settings/client/cli_settings.dart';
import 'package:flutter/material.dart';

class MyClientNav extends StatefulWidget {
  const MyClientNav({super.key});

  @override
  State<MyClientNav> createState() => _MyClientNavState();
}

class _MyClientNavState extends State<MyClientNav> {
  // default index
  int index = 0;
  // screen lists
  final screens = [
    const MyClientDashboard(),
    const MyClientDailyTask(),
    const MyClientTaskAssign(),
    const MyClientSetting()
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
            backgroundColor: const Color(0xffbee6ce),
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
