import 'dart:convert';

import 'package:http/http.dart' as http;

var url = 'http://10.0.2.2:80/clientonboarding/get.php';
dynamic data;
Future<void> getTaskDetailsss() async {
  final response = await http.get(
    Uri.parse('url'),
  );

  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
  }
}



// Future<void> _loadUsers() async {
//   try {
//     final response = await http
//         .get(Uri.parse('http://10.0.2.2:80/clientOnboarding/index.php'));
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body.toString());
//     }

//     // final jsonData = json.decode(response.body);
//   } catch (error) {
//     print(error);
//   }
// }
