// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:local_market_delivery_app/offlinelogin/loginscreen.dart';
// import 'package:lottie/lottie.dart';
// import '../product_details/product_details.dart';
// import 'package:http/http.dart' as http;
// import 'widgets/dashboard_widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MyHome extends StatefulWidget {
//   const MyHome({super.key});

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   // ****
//   var isLoaded = false;
//   var isLoadedPrimary = true;
//   var count = 0;

//   final Map<String, String> headerS = {
//     "Content-Type": "application/json",
//     "User-Agent": "PostmanRuntime/7.30.0",
//     "Accept": "/",
//     "Connection": "keep-alive",
//   };

//   dynamic data;
//   Future<void> getOrderDetails() async {
//     final response = await http.get(
//         Uri.parse(
//             'https://localmt.in/wp-json/wc/v3/orders?consumer_key=ck_8993b48bcb9845cd440866c8ebe33677e852c84e&consumer_secret=cs_dd1ba4342a1516bf95b1e560773abe1dace409d9&_fields=id,status,total,billing,shipping,line_items&status=kolkata-purchase&per_page=100'),
//         headers: headerS);

//     if (response.statusCode == 200) {
//       isLoaded = true;
//       data = jsonDecode(response.body.toString());
//     }
//   }
//   // ****

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.red,
//         centerTitle: false,
//         title: const Text(
//           'LocalMarket Delivery App',
//           style: TextStyle(
//               color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         actions: <Widget>[
//           Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                 onTap: () async {
//                   SharedPreferences pref =
//                       await SharedPreferences.getInstance();
//                   pref.remove("email");

//                   // ignore: use_build_context_synchronously
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const MyLoginOffline()));
//                 },
//                 child: const Icon(
//                   Icons.logout,
//                   size: 26.0,
//                 ),
//               )),
//         ],
//       ),
//       body: FutureBuilder(
//         future: getOrderDetails(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: Lottie.network(
//                   'https://assets8.lottiefiles.com/packages/lf20_HBXF2O.json'),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: data.length,
//               itemBuilder: ((context, index) {
//                 data![index]['status'] == "kolkata-purchase"
//                     ? isLoaded = true
//                     : isLoaded = false;
//                 data![index]['status'] != "kolkata-purchase" ? count++ : null;
//                 (count == data.length) ? isLoadedPrimary = false : null;
//                 // debugPrint("$count");

//                 return Visibility(
//                   visible: isLoadedPrimary,
//                   replacement: Column(
//                     children: [
//                       Lottie.network(
//                           'https://assets1.lottiefiles.com/packages/lf20_PWp984uTBZ.json'),
//                       Text(
//                         'No orders yet',
//                         style: GoogleFonts.lato(fontSize: 20),
//                       )
//                     ],
//                   ),
//                   child: Visibility(
//                     visible: isLoaded,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 5, vertical: 10),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 1, vertical: 1),
//                         decoration: const BoxDecoration(
//                             gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Colors.blue,
//                             Colors.red,
//                           ],
//                         )),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 5, vertical: 10),
//                           decoration: const BoxDecoration(color: Colors.white),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   // order ID
//                                   labelText(text: 'Order ID: '),
//                                   valueText(
//                                       text: data![index]['id'].toString()),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               Row(
//                                 children: [
//                                   // user name
//                                   labelText(text: 'Name: '),
//                                   valueText(
//                                       text: data![index]['billing']
//                                               ['first_name']
//                                           .toString()),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               Row(
//                                 children: [
//                                   // user name
//                                   // status
//                                   labelText(text: 'Order Status: '),
//                                   valueText(
//                                       text: data![index]['status'].toString()),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               // price
//                               Row(
//                                 children: [
//                                   labelText(text: 'Total Price: '),
//                                   valueText(
//                                       text: data![index]['total'].toString()),
//                                   const Spacer(),
//                                   SizedBox(
//                                     height: 40,
//                                     width: 160,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     MyProductDetails(
//                                                         index: index)));
//                                       },
//                                       child: Text(
//                                         'More Details >>>',
//                                         style: GoogleFonts.lato(
//                                             fontSize: 16, color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // -----------------------------------------
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }),
//             );
//           }
//         },
//       ),
//     );
//   }
// }