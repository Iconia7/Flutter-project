import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/musiccontroller.dart';
import 'package:project/views/screens/home.dart';
import 'package:project/views/screens/login.dart';
import 'package:project/views/screens/signup.dart';
import 'package:project/views/screens/songplayer.dart';
import 'package:project/views/screens/splashscreen.dart';

void main() {
  // Initialize MusicController globally
  Get.put(MusicController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => Splashscreen()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(
          name: '/home',
          page: () => HomeScreen(
            isDarkMode: _isDarkMode,
            toggleTheme: toggleTheme,
          ),
        ),
        GetPage(
          name: '/song_player',
          page: () {
            final args = Get.arguments as Map<String, dynamic>;
            return SongPlayerScreen(
              song: args['song'] as Map<String, String>,
              playlist: args['playlist'] as List<Map<String, String>>,
            );
          },
        ),
      ],
    );
  }
}
