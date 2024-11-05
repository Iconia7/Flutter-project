import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/homecontroller.dart';
import 'package:project/views/screens/index.dart';
import 'package:project/views/screens/orders.dart';
import 'package:project/views/screens/settings.dart';

List<Widget> myScreens = [
  const Index(),
  const Orders(),
  const Settings(),
];

const List<BottomNavigationBarItem> myMenus = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "Home",
    backgroundColor: Colors.green,
  ),
  BottomNavigationBarItem(icon: Icon(Icons.library_music), label: "Library"),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
];

DashboardController dashboardController = Get.put(DashboardController());

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            "NEWTON MUSIC",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: myMenus,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black54,
            currentIndex: dashboardController.selectedMenu.value,
            onTap: (pos) => dashboardController.updateSelectedMenu(pos),
          ),
        ),
        body: Obx(
          () => myScreens[dashboardController.selectedMenu.value],
        ),
      ),
    );
  }
}
