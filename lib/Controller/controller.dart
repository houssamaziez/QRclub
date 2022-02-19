import 'package:get/get.dart';

class controller extends GetxController {
  var selectedIndex = 0;

  indchng({endxt}) {
    selectedIndex = endxt;
    update();
  }
}
