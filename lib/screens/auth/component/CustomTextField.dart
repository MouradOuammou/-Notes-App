import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hintText,
    this.iconData,
    this.controller,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final String? hintText;
  final IconData? iconData;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: iconData != null
              ? Icon(iconData, color: Colors.grey)
              : null,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.greenAccent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey.shade800, width: 2),
          ),
        ),
      ),
    );
  }
}
