import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';

class QR extends StatefulWidget {
  @override
  State<QR> createState() => _QRStateState();
}

class _QRStateState extends State<QR> {
  var colaction = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            realtimedata(
              colaction: colaction,
            ),
            qr(context: context),
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
              child: TextField(
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
                  hintText: "TEXT  QR ",
                ),
                onChanged: (val) {
                  setState(() {
                    textQr = val;
                  });
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF54343),
        onPressed: () {
          // Get.to(ScanQR());

          try {
            if (textQr.contains('houssam')) {
              var aStr = textQr.replaceAll(RegExp(r'[^0-9]'), '');
              addpoint(point: resultt + int.parse(aStr));
            }
          } catch (e) {
            Get.snackbar("FormatException", "$e");
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
