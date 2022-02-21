import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/admin/scan_qr.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_notf.dart';
import 'package:qrscanar/screens/home/Home.dart';

// ignore: must_be_immutable
class AddPoint extends StatefulWidget {
  @override
  State<AddPoint> createState() => _AddPointState();
}

var point = 0;

class _AddPointState extends State<AddPoint> {
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
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colors,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add poits ",
          style: TextStyle(color: colors),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.qr_code_scanner_rounded),
        backgroundColor: colors,
        onPressed: () async {
          Get.to(ScanQRAdmin());
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BUTTON ADD NOTIFICATION

          Text(
            point.toString(),
            style: TextStyle(
                color: colors, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: colors),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: colors,
                  width: 5,
                )),
                hintText: "Num points",
              ),
              onChanged: (val) {
                setState(() {
                  point = int.parse(val);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
