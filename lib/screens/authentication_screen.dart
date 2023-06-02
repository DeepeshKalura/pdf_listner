import 'package:flutter/material.dart';
import 'package:pdf_listner/helper/sized_box_helper.dart';
import 'package:pdf_listner/widgets/custom_button.dart';
import 'package:pdf_listner/widgets/custom_text_field.dart';
import 'package:pdf_listner/widgets/screen_background.dart';

class AuthenticationScreen extends StatefulWidget {
  static String routeName = "/authenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController userNameController =
      TextEditingController(); // bhai inno na ap private bana
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

//   Dispose Bhi ker dena sare controller ko

  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: ListView(children: [
              Image.asset(
                "assets/images/icon_image.png",
                height: 150,
              ),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "please enter a username";
                    } else {
                      return null;
                    }
                  },
                  controller: userNameController,
                  hintText: "Enter Your Username",
                  labelText: "Username",
                  prefixIconData: Icons.person),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "please enter a Email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  hintText: "Enter Your Email",
                  labelText: "Email",
                  prefixIconData: Icons.email),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "please enter a username";
                  } else if (value.length < 8) {
                    return "password should be of atleat 8 characters";
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                hintText: "Enter Your Password",
                labelText: "Password",
                prefixIconData: Icons.password,
                suffixIcon: const Icon(Icons.remove_red_eye),
              ),
              SizedBoxHelper.sizedBox20,
              CustomTextField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "please enter a value";
                  } else if (value != passwordController.text) {
                    return "both password does not match";
                  } else {
                    return null;
                  }
                },
                controller: confirmPasswordController,
                hintText: "Enter the password again",
                labelText: "Confirm Password",
                prefixIconData: Icons.password,
                suffixIcon: const Icon(Icons.remove_red_eye),
              ),
              SizedBoxHelper.sizedBox20,
              CustomButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    print("all things are OK");
                  }
                },
                title: "Register",
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("Already have an account? Login"),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("Forget Password?"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
