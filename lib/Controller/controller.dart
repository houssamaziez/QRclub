import 'package:get/get.dart';

// ignore: camel_case_types
class controller extends GetxController {
  var selectedIndex = 0;
  var connect = true;

  indchng({endxt}) {
    selectedIndex = endxt;
    update();
  }

  conctchng({endxt}) {
    connect = endxt;
    update();
  }
}
