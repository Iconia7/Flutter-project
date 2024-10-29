import 'package:flutter/material.dart';

Widget myTextField(
    // this is an example of a function-based widget (a function that returns a widget/its return type is a widget)
    {required TextEditingController
        controller, // this is a required parameter in a pull of optional named parameters
    String hint = "",
    IconData icon = Icons.abc,
    bool isPassword = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30,right: 30),
    child: TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: Colors.lightBlueAccent)),
        prefixIcon: Icon(icon), // adds icon before the text field
        suffixIcon: isPassword
            ? const Icon(Icons.visibility)
            : null // adds icon after the text field
        ),
  ),
  );
}
