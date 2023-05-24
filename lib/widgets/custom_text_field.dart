import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final IconData prefixIconData;
  final Widget ?suffixIcon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,required this.prefixIconData,this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText, labelText: labelText, prefixIcon: Icon(prefixIconData),suffixIcon: suffixIcon),
    );
  }
}
