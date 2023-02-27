import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyDevNewUser extends StatefulWidget {
  const MyDevNewUser({super.key});

  @override
  State<MyDevNewUser> createState() => _MyDevNewUserState();
}

class _MyDevNewUserState extends State<MyDevNewUser> {
  final username = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  postData(context) async {
    var response = await http.post(
        Uri.parse('http://10.0.2.2:80/FlutterApi/dev/createdev.php'),
        body: {
          'cli_username': username.text,
          'cli_password': password.text,
          'cli_name': fullname.text,
          'cli_phone': phone.text,
          'cli_email': email.text,
        });

    if (response.statusCode == 200) {
      username.clear();
      password.clear();
      fullname.clear();
      phone.clear();
      email.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Success!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create New Dev Account'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Column(
            children: [
              // username
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
                      keyboardType: TextInputType.emailAddress,
                      controller: username,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'User Name',
                      ),
                    ),
                  ),
                ),
              ),
              // password
              const SizedBox(height: 15),
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
                      keyboardType: TextInputType.text,
                      controller: password,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
              // name
              const SizedBox(height: 15),
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
                      keyboardType: TextInputType.name,
                      controller: fullname,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                      ),
                    ),
                  ),
                ),
              ),
              // phone
              const SizedBox(height: 15),
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
                      keyboardType: TextInputType.number,
                      controller: phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Phone Number',
                      ),
                    ),
                  ),
                ),
              ),
              // email
              const SizedBox(height: 15),
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
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email ID',
                      ),
                    ),
                  ),
                ),
              ),
              // elevatedbutton
              const SizedBox(height: 50),
              SizedBox(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 100,
                child: ElevatedButton(
                  onPressed: () {
                    postData(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
