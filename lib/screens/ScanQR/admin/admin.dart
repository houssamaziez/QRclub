import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/admin/scan_qr.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_notf.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_points.dart';
import 'package:qrscanar/screens/home/Home.dart';

// ignore: must_be_immutable
class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _AdminState();
}

var ponitdebut;
var notification = "";
var titlenot = "";

class _AdminState extends State<Admin> {
  var msgController = TextEditingController();
  var msgController2 = TextEditingController();
  var islod = false;
  // ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.off(Home(
              id: storg.read("id"),
            ));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add poits ",
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.qr_code_scanner_rounded),
      //   backgroundColor: Colors.red,
      //   onPressed: () async {
      //     Get.to(ScanQRAdmin());
      //   },
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          // BUTTON ADD NOTIFICATION
          MaterialButton(
            color: Colors.red,
            onPressed: () {
              Get.to(const AddNotf());
            },
            child: Text("Add notification"),
          ),
          SizedBox(
            height: 20,
          ),

          MaterialButton(
            color: Colors.red,
            onPressed: () {
              Get.to(AddPoint());
            },
            child: const Text("Add Points"),
          ),
        ],
      ),
    );
  }
}
