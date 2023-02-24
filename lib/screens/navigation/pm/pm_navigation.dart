import 'package:client_onboarding_app/screens/assignproject/pm/assign_project.dart';
import 'package:client_onboarding_app/screens/createuser/developer/createdev.dart';
import 'package:flutter/material.dart';
import '../../createuser/client/createcli.dart';

class MyPmNavigation extends StatefulWidget {
  const MyPmNavigation({super.key});

  @override
  State<MyPmNavigation> createState() => _MyPmNavigationState();
}

class _MyPmNavigationState extends State<MyPmNavigation> {
  // default index
  int index = 0;
  // screen lists
  final screens = [
    const MyProjectDetails(),
    const MyPmCreateClient(),
    const MyDevNewUser()
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
                label: 'client',
              ),
              // task assigned
              NavigationDestination(
                icon: Icon(Icons.assignment_add),
                selectedIcon: Icon(Icons.assignment_add),
                label: 'Developer',
              ),
              // // settings
              // NavigationDestination(
              //   icon: Icon(Icons.settings),
              //   selectedIcon: Icon(Icons.settings),
              //   label: 'Settings',
              // ),
            ]),
      ),
    );
  }
}
