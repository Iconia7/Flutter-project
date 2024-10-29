
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project/views/screens/home.dart';
import 'package:project/views/screens/login.dart';
import 'package:project/views/screens/signup.dart';

List<GetPage> routes = [
  GetPage(name: "/", page:() => const Login()),
  GetPage(name: "/signup", page:() => const Signup()),
  GetPage(name: "/home", page:() => const Home()),
];
