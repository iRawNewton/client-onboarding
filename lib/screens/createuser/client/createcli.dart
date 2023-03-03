import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyPmCreateClient extends StatefulWidget {
  const MyPmCreateClient({super.key});

  @override
  State<MyPmCreateClient> createState() => _MyPmCreateClientState();
}

class _MyPmCreateClientState extends State<MyPmCreateClient> {
  var maxlengthline = 10;

  final cliId = TextEditingController();
  final cliPass = TextEditingController();
  final cliName = TextEditingController();
  final cliEmail = TextEditingController();
  final cliPhone = TextEditingController();
  dynamic data;

  postData(context) async {
    var response = await http.post(
        Uri.parse(
            'https://acp.cwy.mybluehostin.me/demo/gaurabroy/FlutterApi/client/createClient.php'),
        body: {
          'cli_userid': cliId.text,
          'cli_pass': cliPass.text,
          'cli_name': cliName.text,
          'cli_email': cliEmail.text,
          'cli_phone': cliPhone.text,
        });
    if (response.statusCode == 200) {
      cliId.clear();
      cliPass.clear();
      cliName.clear();
      cliEmail.clear();
      cliPhone.clear();

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
  void dispose() {
    cliId.dispose();
    cliPass.dispose();
    cliName.dispose();
    cliEmail.dispose();
    cliPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 60.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10.0),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: const Center(
                        child: Text(
                      'Create New Client Account',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ))),
                const SizedBox(height: 10),
                // client ID
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        maxLength: maxlengthline,
                        controller: cliId,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: cliPass,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: cliName,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: cliEmail,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email ID',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: cliPhone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      postData(context);
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff0101D3))),
                    child: const Text(
                      'Create client account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'fontTwo',
                      ),
                    ),
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
