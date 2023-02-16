import 'package:flutter/material.dart';

class MyDevTaskAssign extends StatefulWidget {
  const MyDevTaskAssign({super.key});

  @override
  State<MyDevTaskAssign> createState() => _MyDevTaskAssignState();
}

class _MyDevTaskAssignState extends State<MyDevTaskAssign> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Task Assigned',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  leading: const Text(
                    'Task 1',
                    style: TextStyle(color: Colors.white),
                  ),
                  title: const Text(
                    'Task Preview',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ListTile(
                  leading: const Text(
                    'Task 2',
                    style: TextStyle(color: Colors.white),
                  ),
                  title: const Text(
                    'Task Preview 2',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
