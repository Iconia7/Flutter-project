import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Edit Button
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.jpeg'),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Newton Mwangi", // Replace with actual user's name
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "mwanginewton239@gmail.com", // Replace with actual email
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit profile logic
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Section: Account Settings
            Text(
              "Account Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Change Email"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle changing email logic
              },
            ),
            ListTile(
              title: Text("Change Password"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle changing password logic
              },
            ),
            ListTile(
              title: Text("Log Out"),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                // Handle log out logic
                _logOut(context);
              },
            ),
            SizedBox(height: 20),

            // Section: App Settings
            Text(
              "App Settings",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text("Notifications"),
              trailing: Switch(
                value: true, // Replace with actual value for notifications status
                onChanged: (value) {
                  // Handle toggle notifications setting
                },
              ),
            ),
            ListTile(
              title: Text("Dark Mode"),
              trailing: Switch(
                value: false, // Replace with actual value for dark mode
                onChanged: (value) {
                  // Handle toggle dark mode setting
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logOut(BuildContext context) {
    // Perform logout logic here, like clearing user data or navigating to the login screen
    // For now, we just navigate back to the login screen:
    Navigator.pushReplacementNamed(context, '/login');
  }
}
