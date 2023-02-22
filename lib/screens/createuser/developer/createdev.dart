import 'package:flutter/material.dart';

class MyDevNewUser extends StatefulWidget {
  const MyDevNewUser({super.key});

  @override
  State<MyDevNewUser> createState() => _MyDevNewUserState();
}

class _MyDevNewUserState extends State<MyDevNewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Column(
          children: [
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
                    keyboardType: TextInputType.emailAddress,
                    // controller: _email,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'User Name',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
