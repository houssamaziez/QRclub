import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';
import 'package:qrscanar/screens/ScanQR/screen_qr.dart';

import '../../main.dart';
import '../home/Home.dart';
import 'Clien/User/add_user.dart';

class ScreenStart extends StatefulWidget {
  const ScreenStart({Key? key}) : super(key: key);

  @override
  State<ScreenStart> createState() => _ScreenStartState();
}

class _ScreenStartState extends State<ScreenStart> {
  @override
  void initState() {
    Timer(Duration(seconds: 6), () {
      storg.read("id") == null
          ? Get.off(() => AddUser())
          : Get.off(() => Home(
                id: storg.read("id"),
              ));
    });
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
        ],
      ),
    );
  }
}
