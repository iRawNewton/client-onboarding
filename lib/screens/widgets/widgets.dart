import 'package:client_onboarding_app/screens/assignproject/pm/assign_project.dart';
import 'package:client_onboarding_app/screens/createuser/client/createcli.dart';
import 'package:client_onboarding_app/screens/createuser/developer/createdev.dart';
import 'package:flutter/material.dart';
import '../dashboard/pm/pm_dashboard.dart';

class MyDrawerInfo extends StatefulWidget {
  const MyDrawerInfo({super.key});

  @override
  State<MyDrawerInfo> createState() => _MyDrawerInfoState();
}

class _MyDrawerInfoState extends State<MyDrawerInfo> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: const EdgeInsets.all(8.0),
        children: [
          const DrawerHeader(
            child: UserAccountsDrawerHeader(
              accountName: Text(
                'Kyptronix LLP',
                style: TextStyle(fontFamily: 'fontOne'),
              ),
              accountEmail:
                  Text('Username', style: TextStyle(fontFamily: 'fontTwo')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title:
                const Text(' Home ', style: TextStyle(fontFamily: 'fontTwo')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyPmDashboard(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title:
                const Text('Clients', style: TextStyle(fontFamily: 'fontTwo')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyPmCreateClient(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.developer_mode),
            title: const Text('Development Team',
                style: TextStyle(fontFamily: 'fontTwo')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyDevNewUser(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title:
                const Text('Projects', style: TextStyle(fontFamily: 'fontTwo')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProjectDetails(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
