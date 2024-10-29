import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/signupcontroller.dart';
import 'package:project/views/widgets/textfield.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 139, 5),
        appBar: AppBar(
          title: const Text(
            "NEWTON DESIGNS",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 139, 5),
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
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
                    "Register",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: fname,
                      hint: "Enter First Name",
                      icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: lname,
                      hint: "Enter Last Name",
                      icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: email,
                      hint: "Enter your Email Address",
                      icon: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: user,
                      hint: "Enter a Username",
                      icon: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: pass,
                      hint: "Password",
                      icon: Icons.lock,
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  myTextField(
                      controller: cpass,
                      hint: "Confirm Password",
                      icon: Icons.lock,
                      isPassword: true),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.toNamed("/home");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
