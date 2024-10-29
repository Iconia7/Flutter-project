import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/logincontroller.dart';
import 'package:project/views/widgets/textfield.dart';

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
        child: Container(
          // the container property is limited to just a rectangular shape
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(55),
              border: Border.all(color: Colors.orangeAccent, width: 4)),
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
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(),
                    ),
                    onPressed: () {
                      Get.toNamed("/signup");
                    },
                  ),
                ],
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
                            backgroundColor: const Color(0xFFFAF9F6));
                      } else if (pass.text.isEmpty) {
                        Get.snackbar(
                            "Validation", "Please provide the Password",
                            icon: const Icon(Icons.error),
                            backgroundColor: const Color(0xFFFAF9F6));
                      } else {
                        Get.toNamed("/home");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        foregroundColor: Colors.white),
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    )),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                child: const Text("Don't have an account?  SignUp"),
                onPressed: () {
                  Get.toNamed("/signup");
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
