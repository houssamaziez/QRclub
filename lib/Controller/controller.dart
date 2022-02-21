import 'package:get/get.dart';

// ignore: camel_case_types
class controller extends GetxController {
  var selectedIndex = 0;

  indchng({endxt}) {
    selectedIndex = endxt;
    update();
  }
}
