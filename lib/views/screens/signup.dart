import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/views/widgets/textfield.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

TextEditingController user = TextEditingController();
TextEditingController pass = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController cpass = TextEditingController();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;

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
                        "Sign Up",
                        style: GoogleFonts.notoSerif(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: user,
                        hint: "Username",
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: email,
                        hint: "Email",
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: pass,
                        hint: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                        controller: cpass,
                        hint: "Confirm Password",
                        icon: Icons.lock,
                        isPassword: true,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (user.text.isEmpty ||
                                      email.text.isEmpty ||
                                      pass.text.isEmpty ||
                                      cpass.text.isEmpty) {
                                    Get.snackbar(
                                        "Error", "All fields are required.",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white);
                                  } else {
                                    serverSignup();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 152, 223),
                            foregroundColor: Colors.white,
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlue),
                                )
                              : Text(
                                  "Signup",
                                  style: GoogleFonts.notoSerif(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style:
                                  GoogleFonts.notoSerif(color: Colors.black)),
                          TextButton(
                            child: Text("Login",
                                style: GoogleFonts.notoSerif(
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(
                                        255, 1, 140, 187))),
                            onPressed: () {
                              Get.toNamed("/login");
                            },
                          ),
                        ],
                      ),
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

  Future<void> serverSignup() async {
    setState(() {
      isLoading = true;
    });

    try {
      http.Response response = await http.post(
        Uri.parse("http://10.5.39.115/musicapp/register.php"),
        body: {
          "Username": user.text.trim(),
          "Email": email.text.trim(),
          "Password": pass.text.trim(),
          "Cpassword": cpass.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        var serverResponse = json.decode(response.body);
        int success = serverResponse['success'];
        if (success == 1) {
          Get.snackbar("Success", "Signup successful!",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.lightBlueAccent,
              colorText: Colors.white);
          Get.toNamed("/login");
        } else {
          Get.snackbar("Error", "Signup failed!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
        }
      } else {
        // ignore: avoid_print
        print("Server Error: ${response.statusCode}");
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
}
