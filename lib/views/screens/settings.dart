import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Account Settings"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text("Notification Settings"),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.privacy_tip),
          title: Text("Privacy Policy"),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Log Out"),
          onTap: () {
            Get.toNamed("/login");
          },
        ),
      ],
    );
  }
}
