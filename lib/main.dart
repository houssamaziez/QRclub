import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/screenstart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

import 'Controller/function.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
  }
}

class _MyAppState extends State<MyApp> {
  iduraccont() async {
    String version;
    String url;
    String pass;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Admine').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() async {
        passwordadmine = pass = querySnapshot.docs[0]["pass"];
        Password.write("Password", pass);
        print(pass + "jezjfzne fzejnfzejnf ");
        version0 = await querySnapshot.docs[1]["version"];
        // version = null;
        urlL = url = querySnapshot.docs[1]["url"];
      });
    }

    print(passwordadmine + " ");
  }

  @override
  void initState() {
    iduraccont();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    iduraccont() async {
      String version;
      String url;
      String pass;
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Admine').get();
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        setState(() async {
          passwordadmine = pass = querySnapshot.docs[0]["pass"];
          Password.write("Password", pass);
          print(pass + "jezjfzne fzejnfzejnf ");
          version0 = await querySnapshot.docs[1]["version"];
          // version = null;
          urlL = url = querySnapshot.docs[1]["url"];
        });
      }

      print(passwordadmine + " ");
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ScreenStart(),
      ),
    );
  }
}
