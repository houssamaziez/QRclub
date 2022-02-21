import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/screens/ScanQR/screenstart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

contect() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    print(
        "____________________________I am connected to a mobile network.____________________________");
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print(
        "____________________________I am connected to a wifi network.____________________________");

    // I am connected to a wifi network.
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    contect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: ScreenStart(),
      ),
    );
  }
}
