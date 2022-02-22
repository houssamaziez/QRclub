import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/screenstart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qrscanar/screens/updata/updata.dart';

import 'Controller/function.dart';

void main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  iduraccont() async {
    // ignore: prefer_typing_uninitialized_variables
    var version;
    var url;
    var pass;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Admine').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      pass = querySnapshot.docs[0]["pass"];
      version = querySnapshot.docs[1]["version"];
      url = querySnapshot.docs[1]["url"];
    }
    setState(() {
      urlL = url;
      version0 = version;
      passwordadmine = pass;
    });
    print(passwordadmine);
  }

  @override
  void initState() {
    // contect();

    iduraccont();

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
