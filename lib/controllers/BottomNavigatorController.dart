import 'package:get/get.dart';

class BottomNavigatorController extends GetxController {
  var selectedIndex = 1.obs;

  void changeIndex(int value) {
    selectedIndex.value = value;
  }
}
