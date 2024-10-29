import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/homecontroller.dart';
import 'package:project/views/screens/index.dart';
import 'package:project/views/screens/orders.dart';
import 'package:project/views/screens/settings.dart';

List myScreens = [const Index(), const Orders(), const Settings()];

const List<BottomNavigationBarItem> myMenus = [
  BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
      backgroundColor: Color.fromARGB(255, 0, 139, 5)),
  BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
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
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        appBar: AppBar(
          title: const Text(
            "NEWTON DESIGNS",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 139, 5),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: myMenus,
              backgroundColor: const Color.fromARGB(255, 0, 139, 5),
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              currentIndex: dashboardController.selectedMenu.value,
              onTap: (pos) => dashboardController.updateSelectedMenu(pos),
              unselectedItemColor: Colors.black,
            )),
        body: Obx(() => myScreens[dashboardController.selectedMenu.value]),
      ),
    );
  }
}
