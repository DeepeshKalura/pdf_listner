import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData prefixIconData;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?) validator;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.labelText,
      required this.prefixIconData,
      this.obscureText = false,
      this.suffixIcon,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            prefixIcon: Icon(prefixIconData),
            suffixIcon:suffixIcon,
       ) ),
    );
  }
}
