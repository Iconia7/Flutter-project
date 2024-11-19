import 'package:flutter/material.dart';
import 'package:project/views/screens/index.dart';
//import 'package:project/views/screens/orders.dart';
import 'package:project/views/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    DashboardScreen(),
    //LibraryScreen(),
    ProfileScreen(),
  ];

  // Titles for each tab
  // final List<String> _titles = [
  //   'Home',
  //   'Library',
  //   'Profile',
  // ];

  // Update the current index when a new tab is selected
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
         "Stream Music App" ,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          if (_currentIndex ==
              0) // Example: Add action buttons only for Home tab
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Action for notifications
              },
            ),
          if (_currentIndex ==
              2) // Example: Add a settings button for Profile tab
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to Settings Screen
              },
            ),
        ],
        elevation: 0, // Flat app bar for modern look
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black.withOpacity(0.6),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
