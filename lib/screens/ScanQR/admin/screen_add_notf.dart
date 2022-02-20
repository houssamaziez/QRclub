import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                'date': DateFormat('kk:mm:ss \n EEE d MMM')
                    .format(DateTime.now())
                    .toString(),
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
          // TITLE OF NOTIFICATION
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: TextField(
              controller: msgController2,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
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
              maxLines: 5,
              controller: msgController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                filled: true,
                isDense: true,
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
        ],
      ),
    );
  }
}
