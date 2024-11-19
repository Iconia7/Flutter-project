import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/configs/routes.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: routes,
      routes: {
        '/': (context) => Splashscreen(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home': (context) => HomeScreen(), // Entry point after login
        '/song_player': (context) => SongPlayerScreen(
            song: ModalRoute.of(context)!.settings.arguments
                as Map<String, String>, playlist: [],),
        //'/playlist': (context) => PlaylistScreen(
        // playlists: ModalRoute.of(context)!.settings.arguments as List<String>, // This should match the parameter name
        //),
      },
    );
  }
}
