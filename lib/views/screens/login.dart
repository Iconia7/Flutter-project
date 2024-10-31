import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/logincontroller.dart';
import 'package:project/views/widgets/textfield.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

TextEditingController name =
    TextEditingController(); // instance 2 of the TextEditingController class
TextEditingController pass =
    TextEditingController(); // instance 2 of the TextEditingController class
LoginController loginController = Get.put(LoginController());

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/background.jpeg',
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
                  Text(
                    "Sign In",
                    style: GoogleFonts.notoSerif(
                        fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: name, hint: "Username", icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      controller: pass,
                      hint: "Password",
                      icon: Icons.lock,
                      isPassword: true),
                  const SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.only(right: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text(
                            "Forgot Password?",
                            style: GoogleFonts.notoSerif(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 1, 140, 187)),
                          ),
                          onPressed: () {
                            Get.toNamed("/signup");
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (name.text.isEmpty) {
                            Get.snackbar(
                                "Validation", "Please provide the Username",
                                icon: const Icon(Icons.error),
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 130, 235));
                          } else if (pass.text.isEmpty) {
                            Get.snackbar(
                                "Validation", "Please provide the Password",
                                icon: const Icon(Icons.error),
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 130, 235));
                          } else {
                            Get.toNamed("/home");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 152, 223),
                            foregroundColor: Colors.white),
                        child: Text("Login",
                            style: GoogleFonts.notoSerif(
                                fontSize: 25, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "---------------------  OR  ---------------------",
                    style: GoogleFonts.notoSerif(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          side: const BorderSide(color: Colors.grey),
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
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
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
                          style: GoogleFonts.notoSerif()),
                      TextButton(
                        child: Text("SignUp",
                            style: GoogleFonts.notoSerif(
                                color: const Color.fromARGB(255, 1, 140, 187))),
                        onPressed: () {
                          Get.toNamed("/signup");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
