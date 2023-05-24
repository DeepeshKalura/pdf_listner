import 'package:flutter/material.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';

class AuthenticationScreen extends StatelessWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(children: [
        Image.asset(
          "assets/images/icon_image.png",
          height: 150,
        ),
        CustomTextField(
            controller: TextEditingController(),
            hintText: "Enter Your Email",
            labelText: "Email",
            prefixIconData: Icons.email)
      ]),
    ));
  }
}
