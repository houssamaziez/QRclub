import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/login.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';
import 'package:qrscanar/screens/ScanQR/admin/admin.dart';
import 'package:qrscanar/screens/ScanQR/scan_qr.dart';

var id;

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  void initState() {
    super.initState();
  }

  var reslt = "";
  var name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            if (reslt == "" && id == "") {
            } else {
              var h = await iduraccont(doc: id);
              if (h == null) {
                await adduser(doc: id, point: 0, name: name);
                await adduserall(doc: id, point: 0, name: name);

                Get.to(Profile(
                  id: id,
                ));
              } else {
                Get.snackbar("Exapsion", "this is an existing accont");
              }
            }
          },
          child: const Icon(Icons.arrow_forward_ios),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Crearte Compte",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.86,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("images/img2.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.to(ScanQR());
                      },
                      child: Card(
                        child: ListTile(
                            leading: const Icon(
                              Icons.qr_code_scanner_outlined,
                              color: Colors.red,
                            ),
                            title: id == null
                                ? const Text("Add Your Code QR ")
                                : Text(" Your Code QR :" + id.toString())),
                      ),
                    ),
                  ),
                  textfild(title: "Name ", valu: name),
                  TextButton(
                      onPressed: () {
                        Get.to(Login());
                      },
                      child: const Text(
                        "i have an account",
                        style: TextStyle(color: Colors.red),
                      )),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ));
  }

  Padding textfild({
    title,
    valu,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.red,
            width: 5,
          )),
          hintText: title,
        ),
        onChanged: (val) {
          setState(() {
            name = val;
          });
        },
      ),
    );
  }
}
