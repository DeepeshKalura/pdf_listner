import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/widgets/custom_button.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
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
        SizedBoxHelper.sizedBox20,
        CustomTextField(
            controller: userNameController,
            hintText: "Enter Your Username",
            labelText: "Username",
            prefixIconData: Icons.person),
        SizedBoxHelper.sizedBox20,
        CustomTextField(
            controller: emailController,
            hintText: "Enter Your Email",
            labelText: "Email",
            prefixIconData: Icons.email),

        SizedBoxHelper.sizedBox20,
        CustomTextField(
            controller:passwordController,
            hintText: "Enter Your Password",
            labelText: "Password",
            prefixIconData: Icons.password,
            suffixIcon:const Icon(Icons.remove_red_eye),
        ),
        SizedBoxHelper.sizedBox20,
        CustomTextField(
            controller: confirmPasswordController,
            hintText: "Enter the password again",
            labelText: "Confirm Password",
            prefixIconData: Icons.password,
            suffixIcon:const Icon(Icons.remove_red_eye),
        ),
        SizedBoxHelper.sizedBox20,
      CustomButton(onPressed: (){},title: "Register",),
        MaterialButton(onPressed: (){},child: Text("Already have an account? Login"),),
        MaterialButton(onPressed: (){},child: Text("Forget Password?"),)
      ]),
    ));
  }
}
