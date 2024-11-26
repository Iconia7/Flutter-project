import 'package:flutter/material.dart';
import 'package:project/views/screens/index.dart';
import 'package:project/views/screens/orders.dart';
import 'package:project/views/screens/settings.dart';

import 'package:project/views/widgets/audioplayermanager.dart';
import 'package:project/views/widgets/miniplayer.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode; // Initial dark mode state
  final ValueChanged<bool> toggleTheme; // Callback to toggle dark mode

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayerManager().audioPlayer;

    // Pages with the dark mode state passed to ProfileScreen
    final List<Widget> pages = [
      DashboardScreen(),
      LibraryScreen(),
      ProfileScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.toggleTheme, // Propagate dark mode toggle
      ),
    ];

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
          // MiniPlayer appears only when a song is playing
          StreamBuilder<bool>(
            stream: audioPlayer.playingStream,
            builder: (context, snapshot) {
              final isPlaying = snapshot.data ?? false;
              if (isPlaying) {
                return MiniPlayer(
                  audioPlayer: audioPlayer,
                  songTitle: "Playing Song Title", // Replace dynamically
                  songImage: "assets/images/song_image.jpg", // Replace dynamically
                );
              }
              return const SizedBox.shrink();
            },
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
