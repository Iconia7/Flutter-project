import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/signupcontroller.dart';
import 'package:project/views/widgets/textfield.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController cpass = TextEditingController();
TextEditingController user = TextEditingController();
SignupController signupController = Get.put(SignupController());

class Signup extends StatelessWidget {
  Signup({super.key});

  final GlobalKey _usernameKey = GlobalKey();
  final GlobalKey _emailKey = GlobalKey();
  final GlobalKey _passwordKey = GlobalKey();
  final GlobalKey _confirmPasswordKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.jpeg',
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.jpeg"),
                        radius: 70,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Welcome",
                          style: GoogleFonts.notoSerif(
                              fontSize: 27, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          key: _usernameKey,
                          controller: user,
                          hint: "Enter a Username",
                          icon: Icons.person),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          key: _emailKey,
                          controller: email,
                          hint: "Enter your Email Address",
                          icon: Icons.email),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          key: _passwordKey,
                          controller: pass,
                          hint: "Password",
                          icon: Icons.lock,
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          key: _confirmPasswordKey,
                          controller: cpass,
                          colour: Colors.grey,
                          hint: "Confirm Password",
                          icon: Icons.lock,
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (user.text.isEmpty) {
                                _showValidationDialog(context,
                                    "Please enter a Username", _usernameKey);
                              } else if (email.text.isEmpty) {
                                _showValidationDialog(context,
                                    "Please enter an Email", _emailKey);
                              } else if (pass.text.isEmpty) {
                                _showValidationDialog(context,
                                    "Please enter a Password", _passwordKey);
                              } else if (cpass.text.isEmpty) {
                                _showValidationDialog(
                                    context,
                                    "Please confirm your Password",
                                    _confirmPasswordKey);
                              } else if (pass.text != cpass.text) {
                                _showValidationDialog(context,
                                    "Passwords do not match", _passwordKey);
                              } else {
                                Get.toNamed("/home");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 152, 223),
                                foregroundColor: Colors.white),
                            child: Text("Register",
                                style: GoogleFonts.notoSerif(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style:
                                  GoogleFonts.notoSerif(color: Colors.black)),
                          TextButton(
                            child: Text("Login",
                                style: GoogleFonts.notoSerif(fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(
                                        255, 1, 140, 187))),
                            onPressed: () {
                              Get.toNamed("/login");
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          ),
        ),
      ]),
    );
  }

  void _showValidationDialog(
      BuildContext context, String message, GlobalKey key) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) {
        final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
        final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

        return Positioned(
          left: offset.dx,
          top: offset.dy - 50, // Position it above the text field
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
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

    // Insert the OverlayEntry into the Overlay
    overlay.insert(overlayEntry);

    // Remove the overlay after a delay
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
