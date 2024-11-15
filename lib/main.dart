import 'package:flutter/material.dart';
import 'package:project/views/screens/home.dart';
import 'package:project/views/screens/login.dart';
//import 'package:project/views/screens/playlist.dart';
import 'package:project/views/screens/signup.dart';
import 'package:project/views/screens/songplayer.dart';
import 'package:project/views/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Splashscreen(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => HomeScreen(),  // Entry point after login
        '/song_player': (context) => SongPlayerScreen(
          song: ModalRoute.of(context)!.settings.arguments as Map<String, String>
        ),
        //'/playlist': (context) => PlaylistScreen(
         // playlists: ModalRoute.of(context)!.settings.arguments as List<String>, // This should match the parameter name
        //),
      },
    );
  }
}
