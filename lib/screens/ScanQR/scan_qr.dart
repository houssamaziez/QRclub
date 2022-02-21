import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/Controller/var.dart';
import 'package:qrscanar/screens/ScanQR/Clien/profile.dart';

import '../home/Home.dart';
import 'Clien/User/add_user.dart';

class ScanQR1 extends StatefulWidget {
  @override
  State<ScanQR1> createState() => _ScanScanQR1State();
}

class _ScanScanQR1State extends State<ScanQR1> {
  QRViewController? controller;
  Barcode? result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  onQRViewCreated(QRViewController controllerr) {
    controller = controllerr;
    controller?.scannedDataStream.listen((event) {
      setState(() async {
        result = event;
        if (result != null) {
          id = result?.code;

          var h = await iduraccont(doc: id);
          if (h == null) {
            Get.back();
            Get.snackbar("Exapsion", "This account does not exist");
          } else {
            Get.off(() => Home(
                  id: id,
                ));
            await storg.write("id", id);
          }
        }
      });
    });
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();

    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 13,
        cutOutSize: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }
}

class ScanQR extends StatefulWidget {
  @override
  State<ScanQR> createState() => _ScanScanQRState();
}

class _ScanScanQRState extends State<ScanQR> {
  QRViewController? controller;
  Barcode? result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  onQRViewCreated(QRViewController controllerr) {
    controller = controllerr;
    controller?.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        if (result != null) {
          id = result?.code;
          Get.off(() => AddUser());
        }
      });
    });
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();

    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 13,
        cutOutSize: MediaQuery.of(context).size.width * 0.6,
      ),
    );
  }
}
