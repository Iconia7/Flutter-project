import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/configs/routes.dart';
import 'package:project/views/screens/home.dart';
import 'package:project/views/screens/login.dart';
import 'package:project/views/screens/settings.dart';
import 'package:project/views/screens/signup.dart';
import 'package:project/views/screens/songplayer.dart';
import 'package:project/views/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Tracks Dark Mode state

  // Toggles between light and dark themes
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
      getPages: routes,
      routes: {
        '/': (context) => Splashscreen(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => HomeScreen(
              isDarkMode: _isDarkMode,
              toggleTheme: toggleTheme,
            ),
        '/song_player': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return SongPlayerScreen(
            song: args['song'] as Map<String, String>,
            playlist: args['playlist'] as List<Map<String, String>>,
          );
        },
        '/profile': (context) => ProfileScreen(
              isDarkMode: _isDarkMode,
              onThemeChanged: toggleTheme,
            ),
      },
    );
  }
}
