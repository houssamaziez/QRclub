import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrscanar/Controller/function.dart';
import 'package:qrscanar/screens/ScanQR/admin/rslt.dart';
import 'package:qrscanar/screens/ScanQR/admin/screen_add_points.dart';

class ScanQRAdmin extends StatefulWidget {
  @override
  State<ScanQRAdmin> createState() => _ScanQRAdminState();
}

class _ScanQRAdminState extends State<ScanQRAdmin> {
  QRViewController? controller;
  Barcode? result;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  onQRViewCreated(QRViewController controllerr) {
    controller = controllerr;
    controller?.scannedDataStream.listen((event) {
      setState(() async {
        result = event;

        if (result != null) {
          var h = await iduraccont(doc: result?.code.toString());

          if (h == null) {
            Get.to(AddPoint());
            Get.snackbar("title", "message");
          } else {
            Get.off(Rslt(
              id: result?.code.toString(),
            ));
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderLength: 10,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
      ],
    );
  }
}
