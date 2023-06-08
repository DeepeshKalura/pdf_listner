import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/widgets/custom_button.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/screen_background.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
            child: ListView(
      children: [
        SizedBoxHelper.sizedBox100,
        Image.asset(
          "assets/images/icon_image.png",
          height: 150,
        ),
        Text(
          "Enter your email to get a reset mail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBoxHelper.sizedBox20,
        CustomTextField(
            controller: emailController,
            hintText: "Enter your  Email",
            labelText: "Email",
            prefixIconData: Icons.email,
            validator: (String? value) {
              if (value!.isEmpty) {
                return "please enter a value";
              }
              return null;
            }),
        SizedBoxHelper.sizedBox20,
        CustomButton(onPressed: () {}, title: "Forgot Password")
      ],
    )));
  }
}
