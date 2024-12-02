import 'package:flutter/material.dart';
import 'package:project/views/screens/index.dart';
import 'package:project/views/screens/orders.dart';
import 'package:project/views/screens/searchscreen.dart';
import 'package:project/views/screens/settings.dart';
//import 'package:project/views/widgets/miniplayer.dart';
//import 'package:project/views/widgets/audioplayermanager.dart';
//import 'package:project/views/screens/songplayer.dart';
//import 'package:project/views/widgets/audioplayermanager.dart';
//import 'package:project/views/widgets/miniplayer.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode; // Initial dark mode state
  final ValueChanged<bool> toggleTheme; // Callback to toggle dark mode

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    // Pages with the dark mode state passed to ProfileScreen
    final List<Widget> pages = [
      DashboardScreen(),
      SearchScreen(),
      LibraryScreen(),
      ProfileScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.toggleTheme, // Propagate dark mode toggle
      ),
    ];

    // ignore: deprecated_member_use
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stream Music App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isDarkMode
                  ? [Colors.grey[900]!, Colors.grey[800]!]
                  : [Colors.lightBlueAccent, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: pages[_currentIndex], // Display current tab content
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.isDarkMode ? Colors.grey[850] : Colors.blue,
        selectedItemColor: widget.isDarkMode ? Colors.white : Colors.white,
        unselectedItemColor: widget.isDarkMode
            ? Colors.grey.withOpacity(0.6)
            : Colors.black.withOpacity(0.6),
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
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
