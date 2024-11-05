import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedMenu = 0.obs;

  void updateSelectedMenu(int index) {
    selectedMenu.value = index;
  }
}

