import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/admin/scan_qr.dart';
import 'package:qrscanar/screens/home/Home.dart';

// ignore: must_be_immutable
class AddNotf extends StatefulWidget {
  const AddNotf({Key? key}) : super(key: key);

  @override
  State<AddNotf> createState() => _AddNotfState();
}

// ignore: prefer_typing_uninitialized_variables
var notification = "";
var titlenot = "";

class _AddNotfState extends State<AddNotf> {
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
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add Notification",
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: islod == true
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Icon(Icons.notification_add),
        backgroundColor: Colors.red,
        onPressed: () async {
          print(islod);
          CollectionReference users =
              FirebaseFirestore.instance.collection('Notification');

          if (titlenot.isEmpty) {
          } else {
            if (notification.isEmpty) {
            } else {
              setState(() {
                islod = true;
              });
              users.add({
                'title': titlenot,
                'date': DateTime.now(),
                'text': notification,
              }).then((value) {
                msgController.clear();
                titlenot = "";
                notification = "";
                msgController2.clear();
                setState(() {
                  islod = false;
                });
              }).catchError((error) {
                setState(() {
                  islod = false;
                });
                print("Failed to add user: $error");
              });
            }
          }
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Add notification",
            style: TextStyle(
                color: Color(0xFFFD5D5D),
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          // TITLE OF NOTIFICATION
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: TextField(
              controller: msgController2,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                  width: 5,
                )),
                hintText: "Title notification",
              ),
              onChanged: (val) {
                setState(() {
                  titlenot = val;
                });
              },
            ),
          ),

          // ADD TEXT OF NOTIFICATION
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: TextField(
              controller: msgController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.red,
                  width: 5,
                )),
                hintText: "Add notification",
              ),
              onChanged: (val) {
                setState(() {
                  notification = val;
                });
              },
            ),
          ),
          // BUTTON ADD NOTIFICATION
          MaterialButton(
            color: Colors.red,
            onPressed: () {},
            child: islod == true ? Text("waiting") : Text("Add notification"),
          ),
        ],
      ),
    );
  }
}