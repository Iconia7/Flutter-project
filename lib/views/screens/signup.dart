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
  const Signup({super.key});

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
                      controller: user,
                      hint: "Enter a Username",
                      icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: email,
                      hint: "Enter your Email Address",
                      icon: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: pass,
                      hint: "Password",
                      icon: Icons.lock,
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
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
                          Get.toNamed("/home");
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 152, 223),
                            foregroundColor: Colors.white),
                        child: Text("Register",
                            style: GoogleFonts.notoSerif(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: GoogleFonts.notoSerif()),
                      TextButton(
                        child: Text("Log in",
                            style: GoogleFonts.notoSerif(
                                color: const Color.fromARGB(255, 1, 140, 187))),
                        onPressed: () {
                          Get.toNamed("/");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ]
          // ),
          ),
    );
  }
}
