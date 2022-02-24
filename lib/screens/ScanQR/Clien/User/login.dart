import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/User/add_user.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';
import 'package:qrscanar/screens/ScanQR/scan_qr.dart';

import '../../../home/Home.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

bool kk = false;

class _LoginState extends State<Login> {
  var id;

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
          backgroundColor: colors,
          onPressed: () async {
            if (id = storg.read("id") != null) {
              setState(() {
                kk = true;
              });
              id = storg.read("id");

              var h = await iduraccont(doc: id);
              if (h == null) {
                Get.snackbar("Error",
                    "This account does not exist or the internet is weak");
              } else {
                Get.off(() => Home(
                      id: id,
                    ));
                await storg.write("id", id);
              }
              setState(() {
                kk = false;
              });
            }
          },
          child: kk == true ? spinkit : Icon(Icons.arrow_forward_ios),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Log in",
            style: TextStyle(color: colors, fontWeight: FontWeight.bold),
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
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: InkWell(
                      onTap: () {
                        Get.to(ScanQR1());
                      },
                      child: Card(
                        child: ListTile(
                            leading: Icon(
                              Icons.qr_code_scanner_outlined,
                              color: colors,
                            ),
                            title: id == null
                                ? const Text("Add Your Code QR ")
                                : Text(" Your Code QR :" + id.toString())),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.offAll(AddUser());
                      },
                      child: Text(
                        "Create an account",
                        style: TextStyle(color: colors),
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: colors),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: colors,
            width: 5,
          )),
          hintText: title,
        ),
        onChanged: (val) {
          setState(() {
            reslt = val;
          });
        },
      ),
    );
  }
}
