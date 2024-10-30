import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/logincontroller.dart';
import 'package:project/views/widgets/textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

TextEditingController name =
    TextEditingController(); // instance 2 of the TextEditingController class
TextEditingController pass =
    TextEditingController(); // instance 2 of the TextEditingController class
LoginController loginController = Get.put(LoginController());

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      //child: (
      padding: const EdgeInsets.all(40),
      child: Center(
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
            myTextField(
                controller: name, hint: "Enter Username", icon: Icons.person),
            const SizedBox(
              height: 20,
            ),
            myTextField(
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
                          color: Color.fromARGB(255, 1, 140, 187)),
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
                      Get.snackbar("Validation", "Please provide the Username",
                          icon: const Icon(Icons.error),
                          backgroundColor:
                              const Color.fromARGB(255, 1, 170, 24));
                    } else if (pass.text.isEmpty) {
                      Get.snackbar("Validation", "Please provide the Password",
                          icon: const Icon(Icons.error),
                          backgroundColor:
                              const Color.fromARGB(255, 1, 189, 57));
                    } else {
                      Get.toNamed("/home");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
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
                child: SignInButton(
                  Buttons.google,
                  text: "Sign in with Google",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: () {},
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?", style: GoogleFonts.notoSerif()),
                TextButton(
                  child: Text("SignUp",
                      style: GoogleFonts.notoSerif(
                          color: Color.fromARGB(255, 1, 140, 187))),
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
    );
  }
}
