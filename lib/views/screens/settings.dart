import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode; // Initial dark mode state
  final ValueChanged<bool> onThemeChanged; // Callback to notify theme change

  const ProfileScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _isDarkMode; 
  bool _isNotificationsEnabled = true; 
  String _name = "Newton Mwangi";
  String _email = "mwanginewton239@gmail.com";

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.jpeg'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditProfileDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Change Email"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showChangeEmailDialog(context),
            ),
            ListTile(
              title: const Text("Change Password"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showInfoDialog(
                  context, "Change Password", "Feature under development!"),
            ),
            ListTile(
              title: const Text("Log Out"),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () => _logOut(context),
            ),
            const SizedBox(height: 20),
            const Text(
              "App Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Notifications"),
              trailing: Switch(
                value: _isNotificationsEnabled,
                onChanged: (value) {
                  setState(() => _isNotificationsEnabled = value);
                },
              ),
            ),
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() => _isDarkMode = value);
                  widget.onThemeChanged(value); 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: _name);
    final emailController = TextEditingController(text: _email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _name = nameController.text;
                _email = emailController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showChangeEmailDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Email"),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: "New Email"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _email = emailController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _logOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
