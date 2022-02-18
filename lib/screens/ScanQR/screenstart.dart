import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/screens/ScanQR/screen_qr.dart';

import '../../main.dart';
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
      Get.off(() => AddUser());
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
                image: AssetImage("images/img1.gif"),
              )),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * .17,
              left: 0,
              right: 0,
              child: const Text(
                'QR Scane',
                style: TextStyle(
                    color: Color(0xFFF54343),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}