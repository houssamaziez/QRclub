// import 'dart:io';

// import 'package:qrscanar/Controller/var.dart';

// Future<bool> checkConnection() async {
//   try {
//     final result = await InternetAddress.lookup("linkedin.com");
//     print(result);
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       print(" connect _______________");

//       return true;
//     } else {
//       print("not connect");
//       return false;
//     }
//   } on SocketException catch (_) {
//     print("not connect");
//     return false;
//   }
// }

// connectvrft() async {
//   if (await checkConnection()) {
//     connect = false;
//   } else {
//     connect = false;
//   }
// }
