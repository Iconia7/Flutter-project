import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/controller/logincontroller.dart';
import 'package:project/views/widgets/textfield.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController name = TextEditingController();
TextEditingController pass = TextEditingController();
LoginController loginController = Get.put(LoginController());

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey _usernameKey = GlobalKey();
  final GlobalKey _passwordKey = GlobalKey();
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkSavedLogin();
  }

  /// Check if user has previously logged in successfully
  Future<void> _checkSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('savedUsername');
    String? savedPassword = prefs.getString('savedPassword');

    if (savedUsername != null && savedPassword != null) {
      // If saved credentials are found, navigate to home
      Get.toNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(75),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.jpeg"),
                        radius: 70,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Sign In",
                        style: GoogleFonts.notoSerif(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                          key: _usernameKey,
                          controller: name,
                          hint: "Username",
                          icon: Icons.person),
                      const SizedBox(height: 20),
                      MyTextField(
                          key: _passwordKey,
                          controller: pass,
                          hint: "Password",
                          icon: Icons.lock,
                          isPassword: true),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                Text(
                                  "Remember Me",
                                  style: GoogleFonts.notoSerif(
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            TextButton(
                              child: Text(
                                "Forgot Password?",
                                style: GoogleFonts.notoSerif(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color:
                                        const Color.fromARGB(255, 1, 140, 187)),
                              ),
                              onPressed: () {
                                Get.toNamed("/signup");
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (name.text.isEmpty) {
                                    _showValidationDialog(
                                        context,
                                        "Please enter a Username",
                                        _usernameKey);
                                  } else if (pass.text.isEmpty) {
                                    _showValidationDialog(
                                        context,
                                        "Please enter a Password",
                                        _passwordKey);
                                  } else {
                                    remoteLogin();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 1, 152, 223),
                              foregroundColor: Colors.white),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlue),
                                )
                              : Text("Login",
                                  style: GoogleFonts.notoSerif(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        "---------------------  OR  ---------------------",
                        style: GoogleFonts.notoSerif(fontSize: 16),
                      ),
                      const SizedBox(height: 7),
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 236, 226, 226),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_icon.png',
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Sign in with Google",
                                  style: GoogleFonts.notoSerif(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style:
                                  GoogleFonts.notoSerif(color: Colors.black)),
                          TextButton(
                            child: Text("SignUp",
                                style: GoogleFonts.notoSerif(
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(
                                        255, 1, 140, 187))),
                            onPressed: () {
                              Get.toNamed("/signup");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Logs the user in and saves credentials if successful.
  Future<void> remoteLogin() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response response = await http.get(Uri.parse(
          "http://10.5.39.115/musicapp/login.php?Username=${name.text.trim()}&Password=${pass.text.trim()}"));

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        int loginStatus = serverResponse['success'];
        if (loginStatus == 1) {
          if (rememberMe) {
            // Save username and password if "Remember Me" is checked
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('savedUsername', name.text.trim());
            prefs.setString('savedPassword', pass.text.trim());
          }
          Get.toNamed("/home");
        } else {
          _showValidationDialog(
              // ignore: use_build_context_synchronously
              context, "Wrong Username or Password", _usernameKey);
        }
      } else {
        // ignore: avoid_print
        print("Server Error ${response.statusCode}");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Shows a validation message near the specified field.
  void _showValidationDialog(
      BuildContext context, String message, GlobalKey key) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) {
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

        return Positioned(
          left: offset.dx,
          top: offset.dy - 50,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

