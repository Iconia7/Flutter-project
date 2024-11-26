import 'package:get/get_navigation/src/routes/get_route.dart';
//import 'package:project/views/screens/home.dart';
import 'package:project/views/screens/login.dart';
import 'package:project/views/screens/signup.dart';
//import 'package:project/views/screens/songplayer.dart';
import 'package:project/views/screens/splashscreen.dart';

List<GetPage> routes = [
  GetPage(name: "/", page: () => const Splashscreen()),
  GetPage(name: "/login", page: () => const Login()),
  GetPage(name: "/signup", page: () => Signup()),
  //GetPage(name: "/home", page: () => const HomeScreen(isDarkMode: null,)),
  //GetPage(name: "/songplayer", page: () => SongPlayer()),
];

