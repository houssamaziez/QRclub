import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/updata/updata.dart';

import '../home/Home.dart';
import 'Clien/User/add_user.dart';

class ScreenStart extends StatefulWidget {
  const ScreenStart({Key? key}) : super(key: key);

  @override
  State<ScreenStart> createState() => _ScreenStartState();
}

class _ScreenStartState extends State<ScreenStart> {
  bool c = false;
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
        version0 = version = await querySnapshot.docs[1]["version"];
        // version = null;
        urlL = url = querySnapshot.docs[1]["url"];
      });
    }

    print(passwordadmine + " ");
  }

  @override
  void initState() {
    iduraccont();
    Timer(Duration(seconds: 5), () {
      storg.read("id") == null
          ? Get.off(() => AddUser())
          : Get.off(() => Home(
                id: storg.read("id"),
              ));
    });
    // Timer(const Duration(seconds: 6), () {
    //   if (version0 == "1.1") {
    //     print(" nooooooooo nuuuuuuuuuuuuuuuuuuuuuul");

    //     storg.read("id") == null
    //         ? Get.off(() => AddUser())
    //         : Get.off(() => Home(
    //               id: storg.read("id"),
    //             ));
    //   } else {
    //     if (version0 == Null) {
    //       print("nuuuuuuuuuuuuuuuuuuuuuul");
    //       storg.read("id") == null
    //           ? Get.off(() => AddUser())
    //           : Get.off(() => Home(
    //                 id: storg.read("id"),
    //               ));
    //     } else {
    //       Get.offAll(const Updata());
    //     }
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
                image: AssetImage("images/img1.png"),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: spinkit,
          )
        ],
      ),
    );
  }
}

final spinkit = SpinKitSpinningLines(
  color: colors,
);
